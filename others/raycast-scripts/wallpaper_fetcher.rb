#!/usr/bin/env mise exec ruby -- ruby
# frozen_string_literal: true

# Required for Raycast
# @raycast.title Thailand Wallpaper
# @raycast.author Raul
# @raycast.authorURL https://github.com/raul-gracia
# @raycast.description Set beautiful Thailand wallpapers from Unsplash
# @raycast.icon 🏯
# @raycast.mode silent
# @raycast.packageName thailand-wallpaper
# @raycast.schemaVersion 1
# @raycast.needsConfirmation false
# @raycast.requiresAdmin false

require 'json'
require 'faraday'
require 'open-uri'
require 'fileutils'
require 'securerandom'

# Replace with your Unsplash API key
UNSPLASH_ACCESS_KEY = '349b927fda5706d62a8245aedb1a6c7a333d5f852800901799f4ce8051d03410'
CACHE_DIR = File.expand_path('~/.thailand-wallpaper-cache')
FileUtils.mkdir_p(CACHE_DIR)

def fetch_random_thailand_photo
  queries = ['thailand national park', 'thailand temple', 'bangkok cityscape', 'thailand beach limestone',
             'thailand culture']
  query = queries.sample

  conn = Faraday.new(url: 'https://api.unsplash.com') do |f|
    f.adapter Faraday.default_adapter
  end

  response = conn.get('/photos/random') do |req|
    req.params = {
      query: query,
      orientation: 'landscape',
      client_id: UNSPLASH_ACCESS_KEY
    }
  end

  if response.success?
    data = JSON.parse(response.body)
    data['urls']['full']
  else
    puts "Error fetching image: #{response.status} #{response.body}"
    exit 1
  end
end

def download_image(url)
  image_path = File.join(CACHE_DIR, "#{SecureRandom.hex}-thailand_wallpaper.jpg")

  URI.open(url) do |image|
    File.open(image_path, 'wb') do |file|
      file.write(image.read)
    end
  end

  image_path
end

def set_wallpaper(image_path)
  script = <<~APPLESCRIPT
    tell application "Finder"
      set desktop picture to POSIX file "#{image_path}"
    end tell
  APPLESCRIPT

  system('osascript', '-e', script)
end

begin
  photo_url = fetch_random_thailand_photo
  image_path = download_image(photo_url)
  set_wallpaper(image_path)
  puts '✨ Wallpaper updated successfully!'
rescue StandardError => e
  puts "Error: #{e.message}"
  exit 1
end
