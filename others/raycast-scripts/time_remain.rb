#!/usr/bin/env mise exec ruby -- ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Time Remaining
# @raycast.mode inline
# @raycast.refreshTime 1h
# @raycast.packageName Time Tracker

# Optional parameters:
# @raycast.icon ⏳
# @raycast.description Shows remaining time for week, month, and year
# @raycast.currentDirectoryPath ~/dotfiles/others/raycast-scripts

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'time'
  gem 'activesupport', '~> 8.0', '>= 8.0.1'
end

require 'time'
require 'date'
require 'active_support'
require 'active_support/time'

def get_remaining_time(current_time)
  # Get end times for different periods
  end_of_week = current_time.end_of_week
  end_of_month = current_time.end_of_month
  end_of_year = current_time.end_of_year

  # Calculate remaining hours and total days for week
  remaining_hours_week = ((end_of_week - current_time) / 1.hour).round
  remaining_days_week = ((end_of_week - current_time) / 1.day).ceil
  current_week = current_time.strftime('%U').to_i + 1

  # Calculate total remaining days for month
  remaining_days_month = (end_of_month - current_time).to_i / 86_400
  remaining_weeks_month = (remaining_days_month / 7.0).floor

  # Calculate total remaining days for year
  remaining_days_year = (end_of_year - current_time).to_i / 86_400
  remaining_weeks_year = (remaining_days_year / 7.0).floor

  {
    week: {
      current: current_week,
      hours: remaining_hours_week,
      days: remaining_days_week
    },
    month: {
      name: current_time.strftime('%B'),
      weeks: remaining_weeks_month,
      total_days: remaining_days_month
    },
    year: {
      current: current_time.year,
      weeks: remaining_weeks_year,
      total_days: remaining_days_year
    }
  }
end

def format_output(time_info)
  week = time_info[:week]
  month = time_info[:month]
  year = time_info[:year]

  parts = []

  # Week information
  week_str = "Week #{week[:current]}"
  week_str += " (#{week[:hours]}h/#{week[:days]}d left)"
  parts << week_str

  # Month information
  month_str = month[:name]
  month_str += " (#{month[:weeks]}w/#{month[:total_days]}d left)"
  parts << month_str

  # Year information
  year_str = year[:current].to_s
  year_str += " (#{year[:weeks]}w/#{year[:total_days]}d left)"
  parts << year_str

  parts.join(' | ')
end

begin
  current_time = Time.now
  time_info = get_remaining_time(current_time)
  puts format_output(time_info)
rescue StandardError => e
  puts "Error: #{e.message}"
  exit 1
end
