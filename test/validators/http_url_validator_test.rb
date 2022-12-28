# typed: true
# frozen_string_literal: true

require "test_helper"

class HttpUrlValidatorTest < ActiveSupport::TestCase
  extend T::Sig

  def setup
    @record = mock
  end

  test "should return nil when url is nil" do
    http_url_validator = HttpUrlValidator.new({ attributes: [:url] })

    actual = http_url_validator.validate_each(@record, :url, nil)

    assert_nil actual
  end

  test "should return nil when url is valid" do
    http_url_validator = HttpUrlValidator.new({ attributes: [:url] })

    actual = http_url_validator.validate_each(@record, :url, "http://domain.com")

    assert_nil actual
  end

  test "should return errors when url is blank" do
    http_url_validator = HttpUrlValidator.new({ attributes: [:url] })
    errors = mock
    errors
      .expects(:add)
      .with(:url, "is not a valid HTTP URL")
    @record.stubs(:errors).returns(errors)

    http_url_validator.validate_each(@record, :url, "")
  end

  test "should return errors when url is not valid" do
    http_url_validator = HttpUrlValidator.new({ attributes: [:url] })
    errors = mock
    errors
      .expects(:add)
      .with(:url, "is not a valid HTTP URL")
    @record.stubs(:errors).returns(errors)

    http_url_validator.validate_each(@record, :url, "domain.com")
  end
end
