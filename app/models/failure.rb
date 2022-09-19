# typed: true
# frozen_string_literal: true

class Failure
  extend T::Sig

  sig { returns(T.nilable(String)) }
  attr_reader :message

  sig { params(message: T.nilable(String)).void }
  def initialize(message)
    @message = message
  end

  sig { params(other: Failure).returns(T::Boolean) }
  def ==(other)
    message == other.message
  end
end
