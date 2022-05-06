class PlayersService
  def players
    Result.new(value: Player.all)
  end

  def player(id)
    player = Player.find_by(id: id)

    if player
      Result.new(value: player)
    else
      failure = ServiceFailure::NotFoundFailure.new('Player was not found')
      Result.new(failure: failure)
    end
  end

  def create(params)
    player = Player.new(params)

    if player.save
      Result.new(value: player)
    else
      failure = ServiceFailure::ValidationFailure.new('Player was not created')
      Result.new(failure: failure)
    end
  end

  def update(id, params)
    player = Player.find_by(id: id)

    if player.update(params)
      Result.new(value: player)
    else
      failure = ServiceFailure::ValidationFailure.new('Player was not updated')
      Result.new(failure: failure)
    end
  end

  def delete(id)
    begin
      Result.new(value: Player.destroy(id))
    rescue ActiveRecord::RecordNotFound
      failure = ServiceFailure::NotFoundFailure.new('Player was not found')
      Result.new(failure: failure)
    rescue => exception
      failure = ServiceFailure::ServerFailure.new('Player was not deleted')
      Result.new(failure: failure)
    end
  end
end
