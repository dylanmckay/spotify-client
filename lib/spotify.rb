require_relative 'query'

require 'net/http'
require 'uri'
require 'json'

BASE_API_URI = "http://ws.spotify.com"
SEARCH_API_URI = "#{BASE_API_URI}/search/1"
SEARCH_TRACK_API_URI = "#{SEARCH_API_URI}/track.json"

class Spotify
  def search_track(query)
    response = Net::HTTP.get_response(query_track_uri(query))

    json_text = response.body
    json_data = JSON.parse(json_text)

    Query.from_json(json_data)
  end

  private

  def query_track_uri(query)
    URI.parse("#{SEARCH_TRACK_API_URI}?q=#{query}")
  end
end
