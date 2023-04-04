# frozen_string_literal: true

require "test_helper"

class PlayersServiceTest < ActiveSupport::TestCase
  def setup
    @players_service = PlayersService.new
  end

  test "should get all players" do
    result = @players_service.players
    assert_equal Player.all, result.value
  end

  test "should get player by id" do
    player = players(:admin)
    result = @players_service.player(player.id)
    assert_equal player, result.value
  end

  test "should not get player by id when id does not exist" do
    result = @players_service.player(-1)
    expected = ServiceFailure::NotFound.new("Player was not found")

    assert_nil result.value
    assert_equal expected, result.failure
  end

  test "should create player" do
    player_params = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
    }

    result = @players_service.create(player_params)

    assert_equal player_params[:first_name], result.value.first_name
    assert_equal player_params[:last_name], result.value.last_name
  end

  test "should not create player when it is not valid" do
    player_params = { "last_name": Faker::Name.last_name }
    expected = ServiceFailure::ValidationFailure.new("Player was not created")

    result = @players_service.create(player_params)

    assert_equal expected, result.failure
  end

  test "should update player" do
    player = players(:admin)
    player_params = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
    }

    result = @players_service.update(player.id, player_params)

    assert_equal player.id, result.value.id
    assert_equal player_params[:first_name], result.value.first_name
    assert_equal player_params[:last_name], result.value.last_name
  end

  test "should not update player when it is not valid" do
    player = players(:admin)
    player_params = { "first_name": nil, "last_name": Faker::Name.last_name }
    expected = ServiceFailure::ValidationFailure.new("Player was not updated")

    result = @players_service.update(player.id, player_params)

    assert_equal expected, result.failure
  end

  test "should delete player" do
    player = players(:free_agent)

    result = @players_service.delete(player.id)

    assert_equal player, result.value
  end

  test "should not delete player when it does not exist" do
    expected = ServiceFailure::NotFound.new("Player was not found")

    result = @players_service.delete(-1)

    assert_equal expected, result.failure
  end

  test "should not delete player when something goes wrong" do
    player = players(:admin)
    expected = ServiceFailure::ServerFailure.new("Player was not deleted")

    Player
      .stubs(:destroy)
      .with(player.id)
      .raises(StandardError, "This is an exception")

    result = @players_service.delete(player.id)

    assert_equal expected, result.failure
  end
end
