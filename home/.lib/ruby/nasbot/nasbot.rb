#!/usr/bin/env ruby

require 'English'
require 'rubygems'
require 'slack-ruby-bot'
require 'mechanize'

SlackRubyBot::Client.logger.level = Logger::WARN

module NASBot
  class App < SlackRubyBot::App
  end

  # Auto-fetching video tracks
  class YouTubeDL < SlackRubyBot::Commands::Base
    match(/^(?:download) (?<url>[^\s]+)/i) do |client, data, match|
      stdout = `
        cd $HOME/memecd
        youtube-dl --extract-audio
                   --prefer-ffmpeg
                   --audio-format mp3
                   --audio-quality 3
                   "#{match[:url]}"
        cd -`

      if $CHILD_STATUS.success?
        m = stdout.match(/.ffmpeg. Destination: (?<song>[^\n]+)/)
        message = "Fetched song successfully: #{m[:song]}"
      else
        message = "Error: #{stdout}"
      end

      client.say(channel: data.channel, text: message)
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
