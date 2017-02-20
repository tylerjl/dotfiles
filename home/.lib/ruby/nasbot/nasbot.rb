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
  old_pwd = Dir.pwd
  Dir.chdir(File.join(ENV['HOME'], 'memecd'))

  stdout = `
    youtube-dl --extract-audio \
               --prefer-ffmpeg \
               --audio-format mp3 \
               --audio-quality 3 \
               "https://www.youtube.com/watch?v=#{id}"`

  r = if $CHILD_STATUS.success?
        if (m = stdout.match(/.ffmpeg. Destination: (?<song>[^\n]+)/))
          # size_mb = File.size(ENV['HOME']+'/memecd/'+m[:song]).to_f / 2**20
          dl = m[:song].match(/^(?<title>.+)-[^.]+[.]mp3$/)
          next_track = Dir['[0-9]*'].sort.last.split('/').last.split(' ').first
            .to_i.succ.to_s.rjust(2, '0')
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

  Dir.chdir old_pwd
  r
end

module NASBot
  class App < SlackRubyBot::App
  end

  # Auto-fetching video tracks
  class YouTubeDL < SlackRubyBot::Commands::Base
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
  end

  # Some web site automation
  class IPTorrents < SlackRubyBot::Commands::Base
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
end

NASBot::App.instance.run
