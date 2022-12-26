# frozen_string_literal: true

require "test_helper"

class ClubsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @club = clubs(:one)
    @player = players(:one)
  end

  test "should show clubs when player is signed in" do
    sign_in @player
    clubs = [@club]
    result = Result.new(value: clubs)
    ClubsService
      .any_instance
      .stubs(:clubs_by_player_id)
      .with(@player.id)
      .returns(result)

    get clubs_url, as: :json

    assert_equal clubs.as_json, response.parsed_body["data"]
    assert_response :success
  end

  test "should not show clubs when player is not signed in" do
    get clubs_url, as: :json

    assert_response :unauthorized
  end

  test "should show club when id exists" do
    result = Result.new(value: @club)
    ClubsService
      .any_instance
      .stubs(:club)
      .with(@club.id.to_s)
      .returns(result)

    get club_url(@club), as: :json

    json = {
      include: [:owner, :players],
      except: [:owner_id],
    }
    assert_equal @club.as_json(json), response.parsed_body["data"]
    assert_response :success
  end

  test "should not show club when it does not exist" do
    message = "Club was not found"
    failure = ServiceFailure::NotFoundFailure.new(message)
    result = Result.new(failure:)
    ClubsService
      .any_instance
      .stubs(:club)
      .with(@club.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::NOT_FOUND, message)
    expected = [api_error]

    get club_url(@club), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :not_found
  end

  test "should create club when it is valid" do
    sign_in @player
    params = {
      club: {
        name: Faker::Team.name,
        description: Faker::Lorem.sentence,
        owner_id: players(:one).id,
      },
    }
    club_params = club_params(params)
    club = Club.new(club_params)
    result = Result.new(value: club)
    ClubsService
      .any_instance
      .stubs(:create)
      .with(club_params).returns(result)

    post clubs_url, params: params, as: :json

    assert_equal club.as_json, response.parsed_body["data"]
    assert_response :created
  end

  test "should not create club when it is not valid" do
    sign_in @player
    params = { club: { name: nil, owner_id: @player.id } }
    club_params = club_params(params)
    message = "Club was not created"
    failure = ServiceFailure::ValidationFailure.new(message)
    result = Result.new(failure:)
    ClubsService
      .any_instance
      .stubs(:create)
      .with(club_params).returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    post clubs_url, params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should not show create club when player is not signed in" do
    post clubs_url, params: nil, as: :json

    assert_response :unauthorized
  end

  test "should update club when it is valid" do
    params = {
      club: {
        name: Faker::Team.name,
        description: Faker::Lorem.sentence,
      },
    }
    club_params = club_params(params)
    result = Result.new(value: @club)
    ClubsService
      .any_instance
      .stubs(:update)
      .with(@club.id.to_s, club_params)
      .returns(result)

    patch club_url(@club), params: params, as: :json

    assert_equal @club.as_json, response.parsed_body["data"]
    assert_response :success
  end

  test "should not update club when it is not valid" do
    params = { club: { name: nil } }
    club_params = club_params(params)
    message = "Club was not updated"
    failure = ServiceFailure::ValidationFailure.new(message)
    result = Result.new(failure:)
    ClubsService
      .any_instance
      .stubs(:update)
      .with(@club.id.to_s, club_params)
      .returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    patch club_url(@club), params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should delete club when id exists" do
    result = Result.new(value: @club)
    ClubsService
      .any_instance
      .stubs(:delete)
      .with(@club.id.to_s)
      .returns(result)

    delete club_url(@club), as: :json

    assert_nil response.parsed_body["data"]
    assert_response :no_content
  end

  test "should not delete club when it does not exist" do
    message = "Club was not found"
    failure = ServiceFailure::NotFoundFailure.new(message)
    result = Result.new(failure:)
    ClubsService
      .any_instance
      .stubs(:delete)
      .with(@club.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::NOT_FOUND, message)
    expected = [api_error]

    delete club_url(@club), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :not_found
  end

  test "should not delete club when something goes wrong" do
    message = "Club was not deleted"
    failure = ServiceFailure::ServerFailure.new(message)
    result = Result.new(failure:)
    ClubsService
      .any_instance
      .stubs(:delete)
      .with(@club.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    delete club_url(@club), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  private

  def club_params(params)
    ActionController::Parameters.new(params)
      .require(:club)
      .permit(
        :name,
        :description,
        :owner_id,
      )
  end
end
