class Result
  attr_accessor :data, :errors, :warnings

  def initialize(data: nil, errors: [], warnings: [])
    @data = data
    @errors = errors
    @warnings = warnings
  end

  def success?
    @errors.empty?
  end

  def failure?
    !success?
  end
end
