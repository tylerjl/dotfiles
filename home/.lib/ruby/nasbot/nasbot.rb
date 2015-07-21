#!/usr/bin/env ruby

require 'rubygems'
require 'slack-ruby-bot'
require 'mechanize'

module NASBot
    class App < SlackRubyBot::App
    end

    class IPTorrents < SlackRubyBot::Commands::Base
        match /(?:iptorrents|ipt) .*(?:balance|points|bonus)/i do |data, _match|
            password = ENV['IPTORRENTS_PASSWORD']
            username = ENV['IPTORRENTS_USERNAME']

            unless password
                send_message data.channel, "Whoops, missing a password for #{username}."
            else
                agent = Mechanize.new
                agent.get('https://iptorrents.com') do |login_page|
                    login_form = login_page.form
                    login_form.username = username
                    login_form.password = password

                    authenticated = agent.submit(login_form, login_form.buttons.first)

                    bonus_page = authenticated.link_with(:href => '/mybonus.php').click

                    bonus_points = bonus_page.search("//font[@id='totalBP']").text.to_i
                    send_message data.channel, "#{username} has #{bonus_points} bonus points."
                    puts 'Logging out...'
                    logout = authenticated.form_with(:action => '/log-out.php')
                    agent.submit(logout)
                end
            end
        end
    end
end

NASBot::App.instance.run
