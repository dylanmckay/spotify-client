class Track
  attr_reader :name, :track_number, :duration_seconds, :popularity

  def initialize(
    name,
    track_number:,
    duration_seconds:,
    popularity:
  )
    @name = name
    @track_number = track_number
    @duration_seconds = duration_seconds
    @popularity = popularity
  end

  def self.from_json(data)
    Track.new(
      data['name'],
      track_number: data['track_number'],
      duration_seconds: data['duration_ms'] / 1000.0,
      popularity: data['popularity'],
    )
  end
end
