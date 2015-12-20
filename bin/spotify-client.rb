#! /usr/bin/env ruby

require_relative '../lib/spotify.rb'

DEFAULT_SEARCH_TERM = "Christmas"

spotify = Spotify.new

puts "Enter a search term: (default: #{DEFAULT_SEARCH_TERM})"
term = $stdin.gets.chomp

term = DEFAULT_SEARCH_TERM if term.strip.empty?

query = spotify.search_track(term)

puts query.run.inspect
