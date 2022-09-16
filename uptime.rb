# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'colorize'
end

uptime_days = `w -hi`.chomp.match(/.* (\d+)days .*/)&.first&.to_i
return if uptime_days.nil?

def message(days)
  case days
  when 1..7
    "#{days} days".green
  when 8..10
    "#{days} days".yellow
  else
    "#{days} days".red
  end
end

puts "Days without restart: #{message(uptime_days)}"