require_relative 'query'

class Spotify
  def search_track(term)
    Query.track(term)
  end
end
