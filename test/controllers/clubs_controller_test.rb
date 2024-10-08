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
      .stubs(:find_all_by_player_id)
      .with(@player.id)
      .returns(result)

    get clubs_url, as: :json

    assert_equal clubs.as_json, response.parsed_body["data"]
    assert_response :success
  end

  test "should not show clubs when player does not have an id" do
    @player.id = nil
    sign_in @player
    message = "Player id is required"
    api_error = ApiError.new(ApiCode::INTERNAL_SERVER, message)
    expected = [api_error]

    get clubs_url, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should not show clubs when player has not signed in" do
    sign_out @player

    get clubs_url, as: :json

    assert_response :unauthorized
  end

  test "should show club when id exists" do
    sign_in @player
    result = Result.new(value: @club)
    ClubsService
      .any_instance
      .stubs(:find)
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

  test "should not show club when player has not signed in" do
    sign_out @player

    get club_url(@club), as: :json

    assert_response :unauthorized
  end

  test "should not show club when it does not exist" do
    sign_in @player
    message = "Club was not found"
    failure = ServiceFailure::NotFound.new(message)
    result = Result.new(value: nil, failure:)
    ClubsService
      .any_instance
      .stubs(:find)
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
      name: Faker::Team.name,
      description: Faker::Lorem.sentence,
      cover_image_path: Faker::Avatar.image,
      owner_id: players(:admin).id,
    }
    club_params = club_params(params)
    club = Club.new(params)
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

  test "should not create club when player has not signed in" do
    sign_out @player

    post clubs_url, params: nil, as: :json

    assert_response :unauthorized
  end

  test "should not create club when it is not valid" do
    sign_in @player
    params = { name: nil, owner_id: @player.id }
    club_params = club_params(params)
    message = "Club was not created"
    failure = ServiceFailure::RecordValidation.new(message)
    result = Result.new(value: nil, failure:)
    ClubsService
      .any_instance
      .stubs(:create)
      .with(club_params)
      .returns(result)
    api_error = ApiError.new(ApiCode::INTERNAL_SERVER, message)
    expected = [api_error]

    post clubs_url, params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should not show create club when player has not signed in" do
    sign_out @player

    post clubs_url, params: nil, as: :json

    assert_response :unauthorized
  end

  test "should update club when it is valid" do
    sign_in @player
    params = {
      name: Faker::Team.name,
      cover_image_path: Faker::Avatar.image,
      description: Faker::Lorem.sentence,
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

  test "should not update club when player has not signed in" do
    sign_out @player

    patch club_url(@club), params: nil, as: :json

    assert_response :unauthorized
  end

  test "should not update club when it is not valid" do
    sign_in @player
    params = { name: nil }
    club_params = club_params(params)
    message = "Club was not updated"
    failure = ServiceFailure::RecordValidation.new(message)
    result = Result.new(value: nil, failure:)
    ClubsService
      .any_instance
      .stubs(:update)
      .with(@club.id.to_s, club_params)
      .returns(result)
    api_error = ApiError.new(ApiCode::INTERNAL_SERVER, message)
    expected = [api_error]

    patch club_url(@club), params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should delete club when id exists" do
    sign_in @player
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

  test "should not delete club when player has not signed in" do
    sign_out @player

    delete club_url(@club), as: :json

    assert_response :unauthorized
  end

  test "should not delete club when it does not exist" do
    sign_in @player
    message = "Club was not found"
    failure = ServiceFailure::NotFound.new(message)
    result = Result.new(value: nil, failure:)
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
    sign_in @player
    message = "Club was not deleted"
    failure = ServiceFailure::InternalServer.new(message)
    result = Result.new(value: nil, failure:)
    ClubsService
      .any_instance
      .stubs(:delete)
      .with(@club.id.to_s)
      .returns(result)
    api_error = ApiError.new(ApiCode::INTERNAL_SERVER, message)
    expected = [api_error]

    delete club_url(@club), as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should get members of club" do
    sign_in @player
    club = clubs(:empty_club)
    player = players(:free_agent)
    players = [player]
    result = Result.new(value: players)
    ClubsService
      .any_instance
      .stubs(:members_by_club_id)
      .with(club.id.to_s)
      .returns(result)

    get club_members_url(club), as: :json

    assert_equal players.as_json, response.parsed_body["data"]
    assert_response :success
  end

  test "should not get members of club when player has not signed in" do
    sign_out @player

    get club_members_url(@club), as: :json

    assert_response :unauthorized
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
    failure = ServiceFailure::DuplicateKey.new(message)
    result = Result.new(value: nil, failure:)
    ClubsService
      .any_instance
      .stubs(:join)
      .with(params)
      .returns(result)
    api_error = ApiError.new(ApiCode::INTERNAL_SERVER, message)
    expected = [api_error]

    post club_members_url(club), params: params, as: :json

    assert_equal expected.as_json, response.parsed_body["errors"]
    assert_response :unprocessable_entity
  end

  test "should not add player to club when player has not signed in" do
    sign_out @player

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
    failure = ServiceFailure::NotFound.new(message)
    result = Result.new(value: nil, failure:)
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
    sign_out @player
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

  def club_params(club)
    params = ActionController::Parameters.new({ club: })
    permitted = T.cast(params.require(:club), ActionController::Parameters)
    permitted.permit(
      :name,
      :description,
      :cover_image_path,
      :owner_id,
    )
  end
end
