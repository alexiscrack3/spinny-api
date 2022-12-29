# typed: true
# frozen_string_literal: true

require "test_helper"

class ClubsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  extend T::Sig

  setup do
    @club = clubs(:club_with_players)
    @player = players(:admin)
  end

  test "should show clubs when player has signed in" do
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

  test "should not show clubs when player does not have an id" do
    @player.id = nil
    sign_in @player
    message = "Player id does not have an id"
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    get clubs_url, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
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
        cover_image_url: Faker::Avatar.image,
        owner_id: players(:admin).id,
      },
    }
    club_params = club_params(params)
    club = Club.new(club_params)
    result = Result.new(value: club)
    ClubsService
      .any_instance
      .stubs(:create)
      .with(club_params)
      .returns(result)

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
      .with(club_params)
      .returns(result)
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
        cover_image_url: Faker::Avatar.image,
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

  test "should add player to club when player has signed in" do
    club = clubs(:empty_club)
    player = players(:free_agent)
    sign_in player
    params = {
      club_id: club.id.to_s,
      player_id: player.id,
    }
    result = Result.new(value: nil)
    ClubsService
      .any_instance
      .stubs(:join)
      .with(params)
      .returns(result)

    post club_members_url(club), params: params, as: :json

    assert_nil response.parsed_body["data"]
    assert_response :created
  end

  test "should not add player to club when membership was not created" do
    club = clubs(:empty_club)
    player = players(:free_agent)
    sign_in player
    params = {
      club_id: club.id.to_s,
      player_id: player.id,
    }
    message = "Club id and Player id already exists"
    failure = ServiceFailure::DuplicateKeyFailure.new(message)
    result = Result.new(failure:)
    ClubsService
      .any_instance
      .stubs(:join)
      .with(params)
      .returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    post club_members_url(club), params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should not add player to club when player has not signed in" do
    club = clubs(:empty_club)
    player = players(:free_agent)
    params = {
      club_id: club.id,
      player_id: player.id,
    }

    post club_members_url(club), params: params, as: :json

    assert_response :unauthorized
  end

  test "should remove player from club when player has signed in" do
    club = clubs(:club_with_players)
    player = players(:player_with_club)
    sign_in player
    params = {
      club_id: club.id.to_s,
      player_id: player.id,
    }
    result = Result.new(value: nil)
    ClubsService
      .any_instance
      .stubs(:join)
      .with(params)
      .returns(result)

    delete club_members_url(club), params: params, as: :json

    assert_nil response.parsed_body["data"]
    assert_response :no_content
  end

  test "should not remove player from club when membership was not deleted" do
    club = clubs(:club_with_players)
    player = players(:player_with_club)
    sign_in player
    params = {
      club_id: club.id.to_s,
      player_id: player.id,
    }
    message = "Membership already exists"
    failure = ServiceFailure::NotFoundFailure.new(message)
    result = Result.new(failure:)
    ClubsService
      .any_instance
      .stubs(:leave)
      .with(params)
      .returns(result)
    api_error = ApiError.new(ApiCode::NOT_FOUND, message)
    expected = [api_error]

    delete club_members_url(club), params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :not_found
  end

  test "should not remove player from club when player has not signed in" do
    club = clubs(:club_with_players)
    player = players(:free_agent)
    params = {
      club_id: club.id,
      player_id: player.id,
    }

    delete club_members_url(club), params: params, as: :json

    assert_response :unauthorized
  end

  private

  sig { params(params: T::Hash[String, T.untyped]).returns(ActionController::Parameters) }
  def club_params(params)
    T.cast(ActionController::Parameters.new(params).require(:club), ActionController::Parameters)
      .permit(
        :name,
        :description,
        :cover_image_url,
        :owner_id,
      )
  end
end
