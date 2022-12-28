# frozen_string_literal: true

class HttpUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?

    if value.blank? || !compliant?(value)
      record.errors.add(attribute, "is not a valid HTTP URL")
    end
  end

  private

  def compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
