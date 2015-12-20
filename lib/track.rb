class Track
  attr_reader :name, :track_number, :popularity

  def initialize(
    name,
    track_number:,
    popularity: 0.5
  )
    @name = name
    @track_number = track_number
    @popularity = popularity
  end

  def self.from_json(data)
    Track.new(
      data['name'],
      track_number: data['track_number'],
      popularity: data['popularity'],
    )
  end
end
