# frozen_string_literal: true

require "test_helper"

class ResultTest < ActiveSupport::TestCase
  test "#success? should return true when failure is nil" do
    result = Result.new(failure: nil)

    assert result.success?
  end

  test "#success? should return false when failure is not nil" do
    result = Result.new(failure: TestFailure.new)

    refute result.success?
  end

  test "#failure? should return true when failure is nil" do
    result = Result.new(failure: nil)

    refute result.failure?
  end

  test "#failure? should return false when failure is not nil" do
    result = Result.new(failure: TestFailure.new)

    assert result.failure?
  end

  test "#empty should return empty result" do
    result = Result.empty

    assert_equal Result.new(value: nil, failure: nil), result
  end

  class TestFailure < Failure
  end
end
