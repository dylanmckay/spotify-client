require_relative 'results'

require 'net/http'
require 'uri'
require 'json'

BASE_API_URI = "https://api.spotify.com/v1"
SEARCH_API_URI = "#{BASE_API_URI}/search"

# 50 is the spotify maximum
DEFAULT_RESULT_COUNT = 50

class Query
  include Enumerable

  def initialize(term, type, offset: 0, limit: DEFAULT_RESULT_COUNT)
    @term = term
    @type = type
    @offset = offset
    @limit = limit
  end

  def self.track(term)
    Query.new(term, 'track')
  end

  def next
    response = Net::HTTP.get_response(uri)

    json_text = response.body
    json_data = JSON.parse(json_text)

    return nil if json_data['tracks'].empty?

    @offset += json_data['tracks'].size

    Results.from_json(json_data)
  end

  def each(&block)
    loop do
      results = self.next

      if results.nil?
        break
      else
        block.call(results)
      end
    end
  end

  private

  def uri
    URI.parse("#{SEARCH_API_URI}?q=#{@term}&type=#{@type}" +
              "&offset=#{@offset}&limit=#{@limit}")
  end
end
