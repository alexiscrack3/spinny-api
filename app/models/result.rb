# frozen_string_literal: true

class Result
  attr_accessor :value, :failure

  def initialize(value: nil, failure: nil)
    @value = value
    @failure = failure
  end

  def success?
    @failure.nil?
  end

  def failure?
    !success?
  end
end
