# typed: true
# frozen_string_literal: true

class GamesService < ApplicationService
  sig { params(id: T.any(String, Integer)).returns(Result[Game]) }
  def game(id)
    game = T.let(Game.find_by(id: id), T.nilable(Game))

    if game
      Result.new(value: game)
    else
      failure = ServiceFailure::NotFoundFailure.new("Game was not found")
      Result.new(failure: failure)
    end
  end

  sig { params(params: T::Hash[String, T.untyped]).returns(Result[Game]) }
  def create(params)
    game = T.let(Game.new(params), Game)

    if game.save
      Result.new(value: game)
    else
      failure = ServiceFailure::ValidationFailure.new("Game was not created")
      Result.new(failure: failure)
    end
  end

  sig { params(id: T.any(String, Integer), params: T::Hash[String, T.untyped]).returns(Result[Game]) }
  def update(id, params)
    game = T.let(Game.find_by(id: id), T.nilable(Game))

    if game&.update(params)
      Result.new(value: game)
    else
      failure = ServiceFailure::ValidationFailure.new("Game was not updated")
      Result.new(failure: failure)
    end
  end

  sig { params(id: T.any(String, Integer)).returns(Result[Game]) }
  def delete(id)
    Result.new(value: Game.destroy(id))
  rescue ActiveRecord::RecordNotFound
    failure = ServiceFailure::NotFoundFailure.new("Game was not found")
    Result.new(failure: failure)
  rescue => _
    failure = ServiceFailure::ServerFailure.new("Game was not deleted")
    Result.new(failure: failure)
  end
end
