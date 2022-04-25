require 'test_helper'

class PlayersServiceTest < ActiveSupport::TestCase
  def setup
    @players_service = PlayersService.new
  end

  test 'should get all players' do
    result = @players_service.players
    assert_equal result.data, Player.all
  end

  test 'should get player by id' do
    player = players(:one)
    result = @players_service.player(player.id)
    assert_equal result.data, player
  end

  test 'should not get player by id when id does not exist' do
    result = @players_service.player(-1)
    assert_nil result.data
  end

  test 'should create player' do
    player_params = {
      'first_name': Faker::Name.first_name,
      'last_name': Faker::Name.last_name
    }

    result = @players_service.create(player_params)

    assert_equal result.data.first_name, player_params[:first_name]
    assert_equal result.data.last_name, player_params[:last_name]
  end

  test 'should not create player when it is not valid' do
    player_params = { 'last_name': Faker::Name.last_name }
    expected = ApiError.new(ApiCode::SERVER_ERROR, 'Player was not created')

    result = @players_service.create(player_params)

    assert_equal result.errors[0].code, expected.code
    assert_equal result.errors[0].message, expected.message
  end

  test 'should update player' do
    player = players(:one)
    player_params = {
      'first_name': Faker::Name.first_name,
      'last_name': Faker::Name.last_name
    }

    result = @players_service.update(player.id, player_params)

    assert_equal result.data.id, player.id
    assert_equal result.data.first_name, player_params[:first_name]
    assert_equal result.data.last_name, player_params[:last_name]
  end

  test 'should not update player when it is not valid' do
    player = players(:one)
    player_params = { 'first_name': nil, 'last_name': Faker::Name.last_name }
    expected = ApiError.new(ApiCode::SERVER_ERROR, 'Player was not updated')

    result = @players_service.update(player.id, player_params)

    assert_equal result.errors[0].code, expected.code
    assert_equal result.errors[0].message, expected.message
  end

  test 'should delete player' do
    player = players(:one)

    result = @players_service.delete(player.id)

    assert_equal result.data, player
  end

  test 'should not delete player when it does not exist' do
    expected = ApiError.new(ApiCode::SERVER_ERROR, 'Player was not deleted')

    result = @players_service.delete(-1)

    assert_equal result.errors[0].code, expected.code
    assert_equal result.errors[0].message, expected.message
  end
end
