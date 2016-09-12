#!/usr/bin/env ruby

require 'rubygems'
require 'slack-ruby-bot'
require 'mechanize'

module NASBot
    class App < SlackRubyBot::App
    end

    class IPTorrents < SlackRubyBot::Commands::Base
        match /(?:iptorrents|ipt) .*(?:balance|points|bonus)/i do |client, data, _match|
            password = ENV['IPTORRENTS_PASSWORD']
            username = ENV['IPTORRENTS_USERNAME']

            unless password
                client.say(channel: data.channel, text: "Whoops, missing a password for #{username}.")
            else
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
            end
        end
    end
end

NASBot::App.instance.run
