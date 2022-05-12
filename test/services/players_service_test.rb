# frozen_string_literal: true

require "test_helper"

class PlayersServiceTest < ActiveSupport::TestCase
  def setup
    @players_service = PlayersService.new
  end

  test "should get all players" do
    result = @players_service.players
    assert_equal result.value, Player.all
  end

  test "should get player by id" do
    player = players(:one)
    result = @players_service.player(player.id)
    assert_equal result.value, player
  end

  test "should not get player by id when id does not exist" do
    result = @players_service.player(-1)
    expected = ServiceFailure::NotFoundFailure.new("Player was not found")

    assert_nil result.value
    assert_equal result.failure, expected
  end

  test "should create player" do
    player_params = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email
    }

    result = @players_service.create(player_params)

    assert_equal result.value.first_name, player_params[:first_name]
    assert_equal result.value.last_name, player_params[:last_name]
  end

  test "should not create player when it is not valid" do
    player_params = { "last_name": Faker::Name.last_name }
    expected = ServiceFailure::ValidationFailure.new("Player was not created")

    result = @players_service.create(player_params)

    assert_equal result.failure, expected
  end

  test "should update player" do
    player = players(:one)
    player_params = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email
    }

    result = @players_service.update(player.id, player_params)

    assert_equal result.value.id, player.id
    assert_equal result.value.first_name, player_params[:first_name]
    assert_equal result.value.last_name, player_params[:last_name]
  end

  test "should not update player when it is not valid" do
    player = players(:one)
    player_params = { "first_name": nil, "last_name": Faker::Name.last_name }
    expected = ServiceFailure::ValidationFailure.new("Player was not updated")

    result = @players_service.update(player.id, player_params)

    assert_equal result.failure, expected
  end

  test "should delete player" do
    player = players(:one)

    result = @players_service.delete(player.id)

    assert_equal result.value, player
  end

  test "should not delete player when it does not exist" do
    expected = ServiceFailure::NotFoundFailure.new("Player was not found")

    result = @players_service.delete(-1)

    assert_equal result.failure, expected
  end

  test "should not delete player when something goes wrong" do
    player = players(:one)
    expected = ServiceFailure::ServerFailure.new("Player was not deleted")

    Player
      .stubs(:destroy)
      .with(player.id)
      .raises(StandardError, "This is an exception")

    result = @players_service.delete(player.id)

    assert_equal result.failure, expected
  end
end
