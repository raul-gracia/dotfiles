#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'httparty'
  gem 'colorize'
  gem 'pry'
end

USER, REPO = `git remote get-url origin`.match(%r{https://github.com/(.+)/(.+)\.git})[1, 2]
TOKEN = ENV['MY_GITHUB_TOKEN']
MAIN_BRANCH = ARGV[0] || 'main'

# Ensure main branch is up-to-date
puts "Checking out #{MAIN_BRANCH}...".blue
`git checkout #{MAIN_BRANCH} > /dev/null 2>&1`
puts 'Updating...'.blue
`git pull > /dev/null`

# Fetch all local branches
local_branches = `git branch --no-color`.split("\n").map(&:strip).reject { |b| b.include? MAIN_BRANCH }

puts "Using URL: https://api.github.com/repos/#{USER}/#{REPO}/pulls".red

local_branches.each do |branch|
  puts "Checking local branch #{branch}...".blue

  response = HTTParty.get(
    "https://api.github.com/repos/#{USER}/#{REPO}/pulls",
    query: { state: 'all', head: "#{USER}:#{branch}" },
    headers: {
      'Authorization' => "Bearer #{TOKEN}",
      'X-GitHub-Api-Version' => '2022-11-28'
    },
    follow_redirects: true
  )

  next if response.nil? || response.empty? || response.not_found?
  raise "Unexpected response: #{response.inspect}" unless response.parsed_response.is_a?(Array)

  pr = response.first
  pr_state = pr['state']
  pr_merged = pr['merged_at']

  if pr_state == 'closed' || pr_merged
    puts "Deleting branch #{branch}...".red
    `git branch -D #{branch}`
  end
end

`git checkout - > /dev/null`
