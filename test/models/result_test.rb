# frozen_string_literal: true

require "test_helper"

class ResultTest < ActiveSupport::TestCase
  test "#success? should return true when failure is nil" do
    actual = Result.new(value: nil, failure: nil)

    assert actual.success?
  end

  test "#success? should return false when failure is not nil" do
    actual = Result.new(value: nil, failure: TestFailure.new)

    refute actual.success?
  end

  test "#failure? should return true when failure is nil" do
    actual = Result.new(value: nil, failure: nil)

    refute actual.failure?
  end

  test "#failure? should return false when failure is not nil" do
    actual = Result.new(value: nil, failure: TestFailure.new)

    assert actual.failure?
  end

  test "#empty should return empty result" do
    actual = Result.empty

    assert_equal Result.new(value: nil, failure: nil), actual
  end

  class TestFailure < Failure
  end
end
