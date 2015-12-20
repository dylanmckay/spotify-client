require_relative 'results'

require 'net/http'
require 'uri'
require 'json'

BASE_API_URI = "https://api.spotify.com/v1"
SEARCH_API_URI = "#{BASE_API_URI}/search"

class Query
  def initialize(term, type)
    @term = term
    @type = type
  end

  def self.track(term)
    Query.new(term, 'track')
  end

  def run
    response = Net::HTTP.get_response(uri)

    json_text = response.body
    json_data = JSON.parse(json_text)

    Results.from_json(json_data)
  end

  private

  def uri
    URI.parse("#{SEARCH_API_URI}?q=#{@term}&type=#{@type}")
  end
end
