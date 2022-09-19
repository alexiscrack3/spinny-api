# typed: true
# frozen_string_literal: true

class PlayersService < ApplicationService
  sig { returns(Result[T::Array[Player]]) }
  def players
    Result.new(value: Player.all)
  end

  sig { params(id: T.nilable(Integer)).returns(Result[Player]) }
  def player(id)
    player = T.let(Player.includes(:clubs).find_by(id: id), T.nilable(Player))

    if player
      Result.new(value: player)
    else
      failure = ServiceFailure::NotFoundFailure.new("Player was not found")
      Result.new(failure: failure)
    end
  end

  sig { params(params: T::Hash[String, T.untyped]).returns(Result[Player]) }
  def create(params)
    player = T.let(Player.new(params), Player)

    if player.save
      Result.new(value: player)
    else
      failure = ServiceFailure::ValidationFailure.new("Player was not created")
      Result.new(failure: failure)
    end
  end

  sig { params(id: T.nilable(Integer), params: T::Hash[String, T.untyped]).returns(Result[Player]) }
  def update(id, params)
    player = T.let(Player.find_by(id: id), T.nilable(Player))

    if player&.update(params)
      Result.new(value: player)
    else
      failure = ServiceFailure::ValidationFailure.new("Player was not updated")
      Result.new(failure: failure)
    end
  end

  sig { params(id: T.nilable(Integer)).returns(Result[Player]) }
  def delete(id)
    Result.new(value: Player.destroy(id))
  rescue ActiveRecord::RecordNotFound
    failure = ServiceFailure::NotFoundFailure.new("Player was not found")
    Result.new(failure: failure)
  rescue => _
    failure = ServiceFailure::ServerFailure.new("Player was not deleted")
    Result.new(failure: failure)
  end
end
