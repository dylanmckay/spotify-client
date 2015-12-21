class PlaylistGenerator
  def initialize(query_results:,
                 duration:,
                 tolerance:,
                 algorithm:)
    @query_results = query_results
    @duration = duration
    @tolerance = tolerance
    @algorithm = algorithm
  end

  def run
    @algorithm.new(
      query_results: @query_results,
      duration: @duration,
      tolerance: @tolerance
    ).run
  end
end
