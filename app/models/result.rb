# typed: true
# frozen_string_literal: true

class Result
  extend T::Sig
  extend T::Generic

  V = type_member

  sig { returns(T.nilable(V)) }
  attr_accessor :value

  sig { returns(T.nilable(Failure)) }
  attr_accessor :failure

  sig do
    type_parameters(:V)
      .params(
        value: T.nilable(V),
        failure: T.nilable(Failure)
      ).void
  end
  def initialize(value: nil, failure: nil)
    @value = value
    @failure = failure
  end

  sig { returns(T::Boolean) }
  def success?
    @failure.nil?
  end

  sig { returns(T::Boolean) }
  def failure?
    !success?
  end
end
