# frozen_string_literal: true

require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup { @player = players(:one) }

  test "should get index" do
    players = [@player]
    result = Result.new(value: players)
    players_service = mock
    players_service.stubs(:players).returns(result)
    PlayersService.stubs(:new).returns(players_service)

    get players_url, as: :json

    assert_equal response.parsed_body["data"], players.as_json
    assert_response :success
  end

  test "should show player" do
    get player_url(@player), as: :json
    assert_response :success
  end

  test "should not show player when it does not exist" do
    @player.id = -1
    api_error = ApiError.new(ApiCode::NOT_FOUND, "Player was not found")
    expected = [api_error]

    get player_url(@player), as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :not_found
  end

  test "should create player" do
    assert_difference("Player.count") do
      params = {
        player: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: "user@spinny.io",
        },
      }
      post players_url, params:, as: :json
    end

    assert_response :created
  end

  test "should not create player when it is not valid" do
    params = { player: { last_name: @player.last_name, email: @player.email } }
    api_error = ApiError.new(ApiCode::SERVER_ERROR, "Player was not created")
    expected = [api_error]

    post players_url, params: params, as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :unprocessable_entity
  end

  test "should update player" do
    params = {
      player: {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: "user@spinny.io",
      },
    }
    patch player_url(@player), params: params, as: :json
    assert_response :success
  end

  test "should not update player when it is not valid" do
    params = {
      player: {
        first_name: nil,
        last_name: Faker::Name.last_name,
        email: "user@spinny.io",
      },
    }
    api_error = ApiError.new(ApiCode::SERVER_ERROR, "Player was not updated")
    expected = [api_error]

    patch player_url(@player), params: params, as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :unprocessable_entity
  end

  test "should destroy player" do
    assert_difference("Player.count", -1) do
      delete player_url(@player), as: :json
    end

    assert_response :no_content
  end

  test "should not destroy player when it does not exist" do
    @player.id = -1
    api_error = ApiError.new(ApiCode::NOT_FOUND, "Player was not found")
    expected = [api_error]

    delete player_url(@player), as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :not_found
  end

  test "should not destroy player when something goes wrong" do
    api_error = ApiError.new(ApiCode::SERVER_ERROR, "Player was not deleted")
    expected = [api_error]
    Player
      .stubs(:destroy)
      .with(@player.id.to_s)
      .raises(StandardError, "This is an exception")

    delete player_url(@player), as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :unprocessable_entity
  end
end
