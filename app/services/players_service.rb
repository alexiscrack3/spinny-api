class PlayersService
  def self.players
    Result.new(data: Player.all)
  end

  def self.player(id)
    player = Player.find_by(id: id)

    if player
      Result.new(data: player)
    else
      errors = [ApiError.new(ApiCode::NOT_FOUND, 'Player was not found')]
      Result.new(errors: errors)
    end
  end

  def self.create(params)
    player = Player.new(params)

    if player.save
      Result.new(data: player)
    else
      errors = [ApiError.new(ApiCode::SERVER_ERROR, 'Player was not created')]
      Result.new(errors: errors)
    end
  end

  def self.update(id, params)
    player = Player.find_by(id: id)

    if player.update(params)
      Result.new(data: player)
    else
      errors = [ApiError.new(ApiCode::SERVER_ERROR, 'Player was not updated')]
      Result.new(errors: errors)
    end
  end

  def self.delete(id)
    begin
      Result.new(data: Player.destroy(id))
    rescue => exception
      errors = [ApiError.new(ApiCode::SERVER_ERROR, 'Player was not deleted')]
      Result.new(errors: errors)
    end
  end
end
