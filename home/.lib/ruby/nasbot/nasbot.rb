#!/usr/bin/env ruby

require 'English'
require 'rubygems'
require 'slack-ruby-bot'
require 'mechanize'
require 'net/http'
require 'json'

SlackRubyBot::Client.logger.level = Logger::WARN

def video_title(id)
  qs = 'id=%s&key=%s&fields=items(snippet(title))&part=snippet'
  api = 'https://www.googleapis.com/youtube/v3/videos'
  JSON.parse(
    Net::HTTP.get(
      URI(format("#{api}?#{qs}", id, ENV['YOUTUBE_API_KEY']))
    )
  )['items'].first['snippet']['title']
end

def fetch_song(id)
  Dir.chdir(File.join(ENV['HOME'], 'memecd')) do

    stdout = `
      youtube-dl --extract-audio \
                 --prefer-ffmpeg \
                 --audio-format mp3 \
                 --audio-quality 3 \
                 "https://www.youtube.com/watch?v=#{id}"`

    if $CHILD_STATUS.success?
      if (m = stdout.match(/.ffmpeg. Destination: (?<song>[^\n]+)/))
        # size_mb = File.size(ENV['HOME']+'/memecd/'+m[:song]).to_f / 2**20
        dl = m[:song].match(/^(?<title>.+)-[^.]+[.]mp3$/)
        if !(files = Dir['[0-9]*']).empty?
          next_track = files.sort.last.split('/').last.split(' ').first.to_i.succ.to_s.rjust(2, '0')
        else
          next_track = '00'
        end
        begin
          File.rename "#{m[:song]}", "#{next_track} #{dl[:title]}.mp3"
        rescue Errno::ENOENT => e
          "Downloaded '#{m[:song]}' but failed to rename: #{e}"
        else
          cd_size = `du -sx .`.match(/^(?<size>\d+)/)[:size].to_i / 1024
          format(
            'Fetched song successfully: "%s". CD directory is %iMB of 600MB (%i%% full)',
            dl[:title],
            cd_size,
            (cd_size.to_f / 600) * 100
          )
        end
      else
        'Hmm, could not parse command output from youtube-dl.'
      end
    else
      "Error: #{stdout}"
    end
  end
end

class NASBot < SlackRubyBot::Bot
  help do
    title 'NAS Bot'
    desc 'A bot running on the fileserver to do lotsa stuff.'

    command 'download <youtube id>' do
      desc 'Download and save a youtube video as an mp3'
      long_desc 'Use: download <youtube id>'
    end

    command 'song list' do
      desc 'List the currrently downloaded songs.'
    end

    command 'ipt points' do
      desc 'Find the number of bonus points on ipt.'
    end
  end

  match(/^(?:download) (?<id>.+)$/i) do |client, data, match|
    client.say(
      channel: data.channel,
      text: "Roger. Fetching '#{video_title(match[:id])}'..."
    )
    client.say(
      channel: data.channel,
      text: fetch_song(match[:id]) + " (for <@#{data.user}>)"
    )
  end

  match(/^song\s+list/i) do |client, data, match|
    list = Dir[File.join(ENV['HOME'], 'memecd') + '/*'].map do |song|
      File.basename song
    end.sort.join("\n")
    client.say(
      channel: data.channel,
      text: "```#{list}```"
    )
  end

  match(/(?:iptorrents|ipt) .*(?:balance|points|bonus)/i) do |client, data, _match|
    password = ENV['IPTORRENTS_PASSWORD']
    username = ENV['IPTORRENTS_USERNAME']

    if password
      agent = Mechanize.new
      agent.get('https://iptorrents.eu/login.php') do |login_page|
        login_form = login_page.form
        login_form.username = username
        login_form.password = password

        authenticated = agent.submit(login_form, login_form.buttons.first)

        bonus_page = authenticated.link_with(:href => '/mybonus.php').click

        bonus_points = bonus_page.search("//font[@id='totalBP']").text.to_i
        client.say(channel: data.channel, text: "#{username} has #{bonus_points} bonus points.")
        puts 'Logging out...'
        logout = authenticated.form_with(:action => '/lout.php')
        agent.submit(logout)
      end
    else
      client.say(
        channel: data.channel,
        text: "Whoops, missing a password for #{username}."
      )
    end
  end
end

NASBot.run
