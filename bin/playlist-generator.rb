#! /usr/bin/env ruby

require_relative '../lib/spotify.rb'
require_relative '../lib/playlist_gen/playlist_gen'
require_relative '../lib/playlist_gen/algorithms/naive'

DEFAULT_SEARCH_TERM = "Christmas"

spotify = Spotify.new

puts "Enter a search term: (default: #{DEFAULT_SEARCH_TERM})"
term = $stdin.gets.chomp

term = DEFAULT_SEARCH_TERM if term.strip.empty?

query = spotify.search_track(term)

results = query.take(5).inject { |a,result| a + result }
duration = 60.0 * 60.0

algorithm = Naive
gen = PlaylistGenerator.new(
  query_results: results,
  duration: duration,
  tolerance: 5.0,
  algorithm: algorithm
)

puts "Tracks:"

track_list = gen.run

track_list.each do |track|
  puts "\t#{track.duration_seconds}s - #{track.name}"
end

puts ""

total_running_time = track_list.inject(0) { |a,track| a+track.duration_seconds }

puts "Total running time: #{total_running_time}"
puts "Which is #{duration-total_running_time}s less than the desired time of #{duration}s"
