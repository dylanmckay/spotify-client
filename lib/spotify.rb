require_relative 'query'

require 'net/http'
require 'uri'
require 'json'

BASE_API_URI = "https://api.spotify.com/v1"
SEARCH_API_URI = "#{BASE_API_URI}/search"

class Spotify
  def search_track(query)
    response = Net::HTTP.get_response(query_track_uri(query))

    json_text = response.body
    json_data = JSON.parse(json_text)

    Query.from_json(json_data)
  end

  private

  def query_track_uri(query)
    query_uri(query, 'track')
  end

  def query_uri(query, type)
    URI.parse("#{SEARCH_API_URI}?q=#{query}&type=#{type}")
  end
end
