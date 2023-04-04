# frozen_string_literal: true

require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @player = players(:admin)
    sign_in @player
  end

  test "should show players when they exist" do
    players = [@player]
    result = Result.new(value: players)
    PlayersService
      .any_instance
      .stubs(:players)
      .returns(result)

    get players_url, as: :json

    assert_equal players.as_json, response.parsed_body["data"]
    assert_response :success
  end

  test "should not show players when they do not exist" do
    result = Result.new(value: [])
    PlayersService
      .any_instance
      .stubs(:players)
      .returns(result)

    get players_url, as: :json

    assert_empty response.parsed_body["data"]
    assert_response :success
  end

  test "should show player when id exists" do
    result = Result.new(value: @player)
    PlayersService
      .any_instance
      .stubs(:player)
      .with(@player.id.to_s)
      .returns(result)

    get player_url(@player), as: :json

    assert_equal @player.as_json(include: :clubs), response.parsed_body["data"]
    assert_response :success
  end

  test "should not show player when it does not exist" do
    message = "Player was not found"
    failure = ServiceFailure::NotFound.new(message)
    result = Result.new(value: nil, failure:)
    PlayersService
      .any_instance
      .stubs(:player)
      .with(@player.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::NOT_FOUND, message)
    expected = [api_error]

    get player_url(@player), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :not_found
  end

  test "should create player when it is valid" do
    params = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
    }
    player_params = player_params(params)
    player = Player.new(params)
    result = Result.new(value: player)
    PlayersService
      .any_instance
      .stubs(:create)
      .with(player_params)
      .returns(result)

    post players_url, params: params, as: :json

    assert_equal player.as_json, response.parsed_body["data"]
    assert_response :created
  end

  test "should not create player when it is not valid" do
    params = {
      first_name: nil,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
    }
    player_params = player_params(params)
    message = "Player was not created"
    failure = ServiceFailure::RecordValidation.new(message)
    result = Result.new(value: nil, failure:)
    PlayersService
      .any_instance
      .stubs(:create)
      .with(player_params)
      .returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    post players_url, params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should update player when it is valid" do
    params = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
    }
    player_params = player_params(params)
    result = Result.new(value: @player)
    PlayersService
      .any_instance
      .stubs(:update)
      .with(@player.id.to_s, player_params)
      .returns(result)

    patch player_url(@player), params: params, as: :json

    assert_equal @player.as_json, response.parsed_body["data"]
    assert_response :success
  end

  test "should not update player when it is not valid" do
    params = {
      first_name: nil,
      last_name: Faker::Name.last_name,
      email: "user@spinny.io",
    }
    player_params = player_params(params)
    message = "Player was not updated"
    failure = ServiceFailure::RecordValidation.new(message)
    result = Result.new(value: nil, failure:)
    PlayersService
      .any_instance
      .stubs(:update)
      .with(@player.id.to_s, player_params)
      .returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    patch player_url(@player), params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should delete player" do
    result = Result.new(value: @player)
    PlayersService
      .any_instance
      .stubs(:delete)
      .with(@player.id.to_s)
      .returns(result)

    delete player_url(@player), as: :json

    assert_nil response.parsed_body["data"]
    assert_response :no_content
  end

  test "should not delete player when it does not exist" do
    message = "Player was not found"
    failure = ServiceFailure::NotFound.new(message)
    result = Result.new(value: nil, failure:)
    PlayersService
      .any_instance
      .stubs(:delete)
      .with(@player.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::NOT_FOUND, message)
    expected = [api_error]

    delete player_url(@player), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :not_found
  end

  test "should not delete player when something goes wrong" do
    message = "Player was not deleted"
    failure = ServiceFailure::ServerFailure.new(message)
    result = Result.new(value: nil, failure:)
    PlayersService
      .any_instance
      .stubs(:delete)
      .with(@player.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    delete player_url(@player), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  private

  def player_params(params)
    ActionController::Parameters.new({ player: params })
      .require(:player)
      .permit(
        :first_name,
        :last_name,
        :email,
      )
  end
end
