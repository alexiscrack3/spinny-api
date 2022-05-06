class Failure
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def ==(failure)
    self.message == failure.message
  end
end
