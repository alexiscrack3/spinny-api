# frozen_string_literal: true

require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
  end

  test "should show game when id exists" do
    result = Result.new(value: @game)
    GamesService
      .any_instance
      .stubs(:game)
      .with(@game.id.to_s)
      .returns(result)

    get game_url(@game), as: :json

    assert_equal @game.as_json(
      include: [:winner, :loser],
      except: [:winner_id, :loser_id],
    ), response.parsed_body["data"]
    assert_response :success
  end

  test "should not show game when it does not exist" do
    message = "Game was not found"
    failure = ServiceFailure::NotFound.new(message)
    result = Result.new(value: nil, failure:)
    GamesService
      .any_instance
      .stubs(:game)
      .with(@game.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::NOT_FOUND, message)
    expected = [api_error]

    get game_url(@game), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :not_found
  end

  test "should create game when it is valid" do
    params = {
      game: {
        winner_id: memberships(:one).id,
        loser_id: memberships(:two).id,
      },
    }
    game_params = game_params(params)
    game = Game.new(game_params)
    result = Result.new(value: game)
    GamesService
      .any_instance
      .stubs(:create)
      .with(game_params)
      .returns(result)

    post games_url, params: params, as: :json

    assert_equal game.as_json, response.parsed_body["data"]
    assert_response :created
  end

  test "should not create game when it is not valid" do
    params = {
      game: {
        winner_id: nil,
        loser_id: nil,
      },
    }
    game_params = game_params(params)
    message = "Game was not created"
    failure = ServiceFailure::RecordValidation.new(message)
    result = Result.new(value: nil, failure:)
    GamesService
      .any_instance
      .stubs(:create)
      .with(game_params)
      .returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    post games_url, params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should update game when it is valid" do
    params = {
      game: {
        winner_id: memberships(:two).id,
        loser_id: memberships(:one).id,
      },
    }
    game_params = game_params(params)
    result = Result.new(value: @game)
    GamesService
      .any_instance
      .stubs(:update)
      .with(@game.id.to_s, game_params)
      .returns(result)

    patch game_url(@game), params: params, as: :json

    assert_equal @game.as_json, response.parsed_body["data"]
    assert_response :success
  end

  test "should not update game when it is not valid" do
    params = {
      game: {
        winner_id: nil,
        loser_id: nil,
      },
    }
    game_params = game_params(params)
    message = "Game was not updated"
    failure = ServiceFailure::RecordValidation.new(message)
    result = Result.new(value: nil, failure:)
    GamesService
      .any_instance
      .stubs(:update)
      .with(@game.id.to_s, game_params)
      .returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    patch game_url(@game), params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should delete game" do
    result = Result.new(value: @game)
    GamesService
      .any_instance
      .stubs(:delete)
      .with(@game.id.to_s)
      .returns(result)

    delete game_url(@game), as: :json

    assert_nil response.parsed_body["data"]
    assert_response :no_content
  end

  test "should not delete game when it does not exist" do
    message = "Game was not found"
    failure = ServiceFailure::NotFound.new(message)
    result = Result.new(value: nil, failure:)
    GamesService
      .any_instance
      .stubs(:delete)
      .with(@game.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::NOT_FOUND, message)
    expected = [api_error]

    delete game_url(@game), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :not_found
  end

  test "should not delete game when something goes wrong" do
    message = "Game was not deleted"
    failure = ServiceFailure::InternalServer.new(message)
    result = Result.new(value: nil, failure:)
    GamesService
      .any_instance
      .stubs(:delete)
      .with(@game.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    delete game_url(@game), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  private

  def game_params(params)
    ActionController::Parameters.new(params)
      .require(:game)
      .permit(:winner_id, :loser_id)
  end
end
