# typed: true
# frozen_string_literal: true

class PlayersService < ApplicationService
  sig { returns(Result[T::Array[Player]]) }
  def find_all
    Result.new(value: Player.all)
  end

  sig { params(id: T.any(String, Integer)).returns(Result[Player]) }
  def find(id)
    player = T.let(Player.includes(:clubs).find_by(id: id), T.nilable(Player))

    if player
      Result.new(value: player)
    else
      failure = ServiceFailure::NotFound.new("Player was not found")
      Result.new(value: nil, failure: failure)
    end
  end

  sig { params(id: T.any(String, Integer), params: T::Hash[String, T.untyped]).returns(Result[Player]) }
  def update(id, params)
    player = T.let(Player.find_by(id: id), T.nilable(Player))

    if player&.update(params)
      Result.new(value: player)
    else
      failure = ServiceFailure::RecordValidation.new("Player was not updated")
      Result.new(value: nil, failure: failure)
    end
  end
end
