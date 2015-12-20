require_relative 'track'
require_relative 'album'

class Query
  def initialize(tracks)
    @tracks = tracks
  end

  def self.from_json(data)
    track_datum = data['tracks']

    tracks = track_datum.map do |track_data|
      track = Track.from_json(track_data)
      album = Album.from_json(track_data['album'])

      album << track
      album
    end

    Query.new(tracks)
  end
end
