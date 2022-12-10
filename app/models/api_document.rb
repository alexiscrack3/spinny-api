# typed: true
# frozen_string_literal: true

class ApiDocument
  extend T::Sig

  sig do
    params(
      data: T.untyped,
      errors: T::Array[ApiError],
      warnings: T::Array[T.untyped],
    ).void
  end
  def initialize(data: nil, errors: [], warnings: [])
    @data = data
    @errors = errors
    @warnings = warnings
  end
end
