# frozen_string_literal: true

require "test_helper"

class GamesServiceTest < ActiveSupport::TestCase
  def setup
    @games_service = GamesService.new
  end

  test "should get game by id" do
    game = games(:one)
    result = @games_service.game(game.id)
    assert_equal result.value, game
  end

  test "should not get game by id when id does not exist" do
    result = @games_service.game(-1)
    expected = ServiceFailure::NotFoundFailure.new("Game was not found")

    assert_nil result.value
    assert_equal result.failure, expected
  end

  test "should create game" do
    winner = memberships(:one)
    loser = memberships(:two)
    game_params = {
      winner: winner,
      loser: loser,
    }

    result = @games_service.create(game_params)

    assert result.value.winner_id, game_params[:winner].id

    assert result.value.loser_id, game_params[:loser].id
  end

  test "should not create game when it is not valid" do
    game_params = { "winner": nil, "loser": nil }
    expected = ServiceFailure::ValidationFailure.new("Game was not created")

    result = @games_service.create(game_params)

    assert_equal result.failure, expected
  end

  test "should update game" do
    winner = memberships(:one)
    loser = memberships(:two)
    game = games(:one)
    game_params = {
      winner: loser,
      loser: winner,
    }

    result = @games_service.update(game.id, game_params)

    assert_equal result.value.id, game.id
    assert_equal result.value.winner_id, game_params[:winner].id
    assert_equal result.value.loser_id, game_params[:loser].id
  end

  test "should not update game when it is not valid" do
    game = games(:one)
    game_params = { "winner": nil, "loser": nil }
    expected = ServiceFailure::ValidationFailure.new("Game was not updated")

    result = @games_service.update(game.id, game_params)

    assert_equal result.failure, expected
  end

  test "should delete game" do
    game = games(:one)

    result = @games_service.delete(game.id)

    assert_equal result.value, game
  end

  test "should not delete game when it does not exist" do
    expected = ServiceFailure::NotFoundFailure.new("Game was not found")

    result = @games_service.delete(-1)

    assert_equal result.failure, expected
  end

  test "should not delete game when something goes wrong" do
    game = games(:one)
    expected = ServiceFailure::ServerFailure.new("Game was not deleted")

    Game
      .stubs(:destroy)
      .with(game.id)
      .raises(StandardError, "This is an exception")

    result = @games_service.delete(game.id)

    assert_equal result.failure, expected
  end
end
