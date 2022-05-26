# frozen_string_literal: true

class GamesService
  def game(id)
    game = Game.find_by(id: id)

    if game
      Result.new(value: game)
    else
      failure = ServiceFailure::NotFoundFailure.new("Game was not found")
      Result.new(failure: failure)
    end
  end

  def create(params)
    game = Game.new(params)

    if game.save
      Result.new(value: game)
    else
      failure = ServiceFailure::ValidationFailure.new("Game was not created")
      Result.new(failure: failure)
    end
  end

  def update(id, params)
    game = Game.find_by(id: id)

    if game.update(params)
      Result.new(value: game)
    else
      failure = ServiceFailure::ValidationFailure.new("Game was not updated")
      Result.new(failure: failure)
    end
  end

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
