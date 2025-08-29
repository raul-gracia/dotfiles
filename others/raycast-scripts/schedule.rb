#!/usr/bin/env mise exec ruby -- ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Current Task
# @raycast.mode inline
# @raycast.refreshTime 5m
# @raycast.packageName Schedule Viewer

# Optional parameters:
# @raycast.icon 🗓
# @raycast.description Shows current task from schedule.json
# @raycast.currentDirectoryPath ~/dotfiles/others/raycast-scripts

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'json'
  gem 'time'
end

require 'json'
require 'time'

def load_schedule
  schedule_path = File.expand_path('~/schedule.json')
  JSON.parse(File.read(schedule_path))
rescue JSON::ParserError => e
  puts "Error: Failed to parse schedule - #{e.message}"
  exit 1
rescue Errno::ENOENT
  puts 'Error: Schedule file not found at ~/schedule.json'
  exit 1
end

def get_current_activity(schedule)
  current_time = Time.now
  day = current_time.strftime('%A')
  hour = current_time.strftime('%H:00')

  return nil unless schedule[day] && schedule[day][hour]

  schedule[day][hour]
end

def format_output(activity)
  return 'No scheduled activity' if activity.nil? || activity.empty?

  # Remove emoji prefix if present (e.g., "🟩 Work" -> "Work")
  activity = activity.gsub(/^[^\w\s]+ /, '') if activity.match?(/^[^\w\s]+ /)

  case activity.downcase
  when /work/
    "👨‍💻 #{activity}"
  when /gym|strength|swimming/
    "💪 #{activity}"
  when /breakfast|lunch|dinner/
    "🍽 #{activity}"
  when /rest/
    "😴 #{activity}"
  when /thai study/
    "📚 #{activity}"
  when /business dev/
    "💼 #{activity}"
  when /salsa class/
    "💃 #{activity}"
  when /life admin/
    "📋 #{activity}"
  else
    "• #{activity}"
  end
end

begin
  schedule = load_schedule
  current_activity = get_current_activity(schedule)
  formatted_time = Time.now.strftime('%H:%M')
  puts "#{formatted_time} | #{format_output(current_activity)}"
rescue StandardError => e
  puts "Error: #{e.message}"
  exit 1
end
