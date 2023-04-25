# typed: true
# frozen_string_literal: true

require "test_helper"

class GamesServiceTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @games_service = T.let(GamesService.new, GamesService)
  end

  test "should get game by id" do
    game = games(:one)
    result = @games_service.find(game.id)
    assert_equal game, result.value
  end

  test "should not get game by id when id does not exist" do
    result = @games_service.find(-1)
    expected = ServiceFailure::NotFound.new("Game was not found")

    assert_nil result.value
    assert_equal expected, result.failure
  end

  test "should create game" do
    winner = memberships(:one)
    loser = memberships(:two)
    params = {
      game: {
        winner_id: winner.id,
        loser_id: loser.id,
      },
    }
    game_params = game_params(params)

    result = @games_service.create(game_params)

    assert result.value.winner_id, winner.id

    assert result.value.loser_id, loser.id
  end

  test "should not create game when it is not valid" do
    params = {
      game: {
        winner_id: nil,
        loser_id: nil,
      },
    }
    game_params = game_params(params)
    expected = ServiceFailure::RecordValidation.new("Game was not created")

    result = @games_service.create(game_params)

    assert_equal expected, result.failure
  end

  test "should update game" do
    winner = memberships(:one)
    loser = memberships(:two)
    game = games(:one)
    params = {
      game: {
        winner_id: winner.id,
        loser_id: loser.id,
      },
    }
    game_params = game_params(params)

    result = @games_service.update(game.id, game_params)

    assert_equal result.value.id, game.id
    assert_equal result.value.winner_id, winner.id
    assert_equal result.value.loser_id, loser.id
  end

  test "should not update game when it is not valid" do
    game = games(:one)
    params = {
      game: {
        winner_id: nil,
        loser_id: nil,
      },
    }
    game_params = game_params(params)
    expected = ServiceFailure::RecordValidation.new("Game was not updated")

    result = @games_service.update(game.id, game_params)

    assert_equal expected, result.failure
  end

  test "should delete game" do
    game = games(:one)

    result = @games_service.delete(game.id)

    assert_equal game, result.value
  end

  test "should not delete game when it does not exist" do
    expected = ServiceFailure::NotFound.new("Game was not found")

    result = @games_service.delete(-1)

    assert_equal expected, result.failure
  end

  test "should not delete game when something goes wrong" do
    game = games(:one)
    expected = ServiceFailure::InternalServer.new("Game was not deleted")

    Game
      .stubs(:destroy)
      .with(game.id)
      .raises(StandardError, "This is an exception")

    result = @games_service.delete(game.id)

    assert_equal expected, result.failure
  end

  private

  sig { params(params: T::Hash[String, T.untyped]).returns(ActionController::Parameters) }
  def game_params(params)
    T.cast(
      ActionController::Parameters.new(params).require(:game),
      ActionController::Parameters,
    ).permit(
      :winner_id,
      :loser_id,
    )
  end
end
