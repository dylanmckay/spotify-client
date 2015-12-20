class Album
  attr_reader :name, :tracks

  def initialize(name, tracks:)
    @name = name
    @tracks = tracks
  end

  def self.from_json(data)
    @name = data['name']
    Album.new(@name, tracks: [])
  end

  def <<(track)
    @tracks << track
  end
end
