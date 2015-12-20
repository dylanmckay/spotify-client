require_relative 'track'
require_relative 'album'

class Query
  def initialize(albums)
    @albums = albums
  end

  def self.from_json(data)
    track_datum = data['tracks']['items']

    albums = track_datum.map do |track_data|
      track = Track.from_json(track_data)
      album = Album.from_json(track_data['album'])

      album << track
      album
    end

    Query.new(albums)
  end
end
