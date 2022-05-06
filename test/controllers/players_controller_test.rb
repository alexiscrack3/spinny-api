require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup { @player = players(:one) }

  test 'should get index' do
    get players_url, as: :json
    assert_response :success
  end

  test 'should create player' do
    assert_difference('Player.count') do
      post players_url,
           params: {
             player: {
               first_name: @player.first_name,
               last_name: @player.last_name
             }
           },
           as: :json
    end

    assert_response :created
  end

  test 'should not create player when it is not valid' do
    expected = [
      { 'code' => ApiCode::SERVER_ERROR, 'message' => 'Player was not created' }
    ]

    post players_url,
         params: {
           player: {
             last_name: @player.last_name
           }
         },
         as: :json

    assert_equal response.parsed_body['errors'], expected
    assert_response :unprocessable_entity
  end

  test 'should show player' do
    get player_url(@player), as: :json
    assert_response :success
  end

  test 'should not show player when it does not exist' do
    @player.id = -1
    expected = [
      { 'code' => ApiCode::NOT_FOUND, 'message' => 'Player was not found' }
    ]

    get player_url(@player), as: :json

    assert_equal response.parsed_body['errors'], expected
    assert_response :not_found
  end

  test 'should update player' do
    patch player_url(@player),
          params: {
            player: {
              first_name: @player.first_name,
              last_name: @player.last_name
            }
          },
          as: :json
    assert_response :success
  end

  test 'should not update player when it is not valid' do
    expected = [
      { 'code' => ApiCode::SERVER_ERROR, 'message' => 'Player was not updated' }
    ]

    patch player_url(@player),
          params: {
            player: {
              first_name: nil,
              last_name: @player.last_name
            }
          },
          as: :json

    assert_equal response.parsed_body['errors'], expected
    assert_response :unprocessable_entity
  end

  test 'should destroy player' do
    assert_difference('Player.count', -1) do
      delete player_url(@player), as: :json
    end

    assert_response :no_content
  end

  test 'should not destroy player when it does not exist' do
    @player.id = -1
    expected = [
      { 'code' => ApiCode::NOT_FOUND, 'message' => 'Player was not found' }
    ]

    delete player_url(@player), as: :json

    assert_equal response.parsed_body['errors'], expected
    assert_response :not_found
  end

  test 'should not destroy player when something went wrong' do
    expected = [
      { 'code' => ApiCode::SERVER_ERROR, 'message' => 'Player was not deleted' }
    ]
    Player
      .stubs(:destroy)
      .with(@player.id.to_s)
      .raises(StandardError, 'This is an exception')

    delete player_url(@player), as: :json

    assert_equal response.parsed_body['errors'], expected
    assert_response :unprocessable_entity
  end
end
