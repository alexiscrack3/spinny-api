# frozen_string_literal: true

class Failure
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def ==(other)
    message == other.message
  end
end
