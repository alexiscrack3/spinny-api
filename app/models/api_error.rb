# frozen_string_literal: true

class ApiError
  attr_accessor :code, :message

  def initialize(code, message)
    @code = code
    @message = message
  end
end
