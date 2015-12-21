class Naive
  def initialize(query_results:, duration:, tolerance:)
    @query_results = query_results
    @duration = duration
    @tolerance = tolerance

    @tracks = []
  end

  def run
    @tracks = []

    while !finished?
      track = possible_tracks.first

      break if track.nil?

      @tracks << possible_tracks.first
    end

    @tracks
  end

  private

  def possible_tracks
    queried_tracks.select do |track|
     track.duration_seconds < remaining_duration &&
       !@tracks.any? { |t| t.name.downcase == track.name.downcase }
    end.sort_by { |track| -track.duration_seconds }
  end

  def queried_tracks
    @query_results.albums.flat_map(&:tracks)
  end

  def finished?
    remaining_duration < @tolerance
  end

  def remaining_duration
    [0, @duration - total_duration].max
  end

  def total_duration
    @tracks.inject(0.0) { |accum,track| accum + track.duration_seconds }
  end
end
