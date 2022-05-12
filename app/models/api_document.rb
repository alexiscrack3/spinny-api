class ApiDocument
  def initialize(data: nil, errors: [], warnings: [])
    @data = data
    @errors = errors
    @warnings = warnings
  end
end
