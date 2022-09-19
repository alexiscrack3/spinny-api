# typed: true
# frozen_string_literal: true

class ApiError
  extend T::Sig

  sig { returns(String) }
  attr_accessor :code

  sig { returns(T.nilable(String)) }
  attr_accessor :message

  sig { params(code: String, message: T.nilable(String)).void }
  def initialize(code, message)
    @code = code
    @message = message
  end
end
