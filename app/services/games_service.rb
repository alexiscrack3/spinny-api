class GamesService
  def games
    Games.all
  end

  def game(id)
    Games.find_by(id: id)
  end

  def create(params)
    game = Games.new(params)
    game.save
  end

  def update(id, params)
    game = Games.find_by(id: id)
    game.update(params)
  end

  def delete(id)
    Games.destroy(id)
  end
end
