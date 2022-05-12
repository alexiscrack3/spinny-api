# frozen_string_literal: true

require "test_helper"

class ClubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club = clubs(:one)
    @clubs_service = mock
    ClubsService.stubs(:new).returns(@clubs_service)
  end

  test "should show club" do
    result = Result.new(value: @club)
    @clubs_service.stubs(:club).with(@club.id.to_s).returns(result)

    get club_url(@club), as: :json

    assert_equal response.parsed_body["data"], @club.as_json
    assert_response :success
  end

  test "should not show club when it does not exist" do
    message = "Club was not found"
    failure = ServiceFailure::NotFoundFailure.new(message)
    result = Result.new(failure:)
    @clubs_service.stubs(:club).with(@club.id.to_s).returns(result)
    api_error = ApiError.new(ApiCode::NOT_FOUND, message)
    expected = [api_error]

    get club_url(@club), as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :not_found
  end

  test "should create club" do
    club_params = ActionController::Parameters.new(club: { name: Faker::Team.name })
                                              .require(:club).permit(:name)
    club = Club.new(club_params)
    result = Result.new(value: club)
    @clubs_service.stubs(:create).with(club_params).returns(result)

    post clubs_url, params: { club: club_params }, as: :json

    assert_equal response.parsed_body["data"], club.as_json
    assert_response :created
  end

  test "should not create club when it is not valid" do
    club_params = ActionController::Parameters.new(club: { name: nil })
                                              .require(:club).permit(:name)
    message = "Club was not created"
    failure = ServiceFailure::ValidationFailure.new(message)
    result = Result.new(failure:)
    @clubs_service.stubs(:create).with(club_params).returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    post clubs_url, params: { club: club_params }, as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :unprocessable_entity
  end

  test "should update club" do
    club_params = ActionController::Parameters.new(club: { name: Faker::Team.name })
                                              .require(:club).permit(:name)

    result = Result.new(value: @club)
    @clubs_service.stubs(:update).with(@club.id.to_s, club_params).returns(result)

    patch club_url(@club), params: { club: club_params }, as: :json

    assert_equal response.parsed_body["data"], @club.as_json
    assert_response :success
  end

  test "should not update club when it is not valid" do
    club_params = ActionController::Parameters.new(club: { name: Faker::Team.name })
                                              .require(:club).permit(:name)
    message = "Club was not updated"
    failure = ServiceFailure::ValidationFailure.new(message)
    result = Result.new(failure:)
    @clubs_service.stubs(:update).with(@club.id.to_s, club_params).returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    patch club_url(@club), params: { club: club_params }, as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :unprocessable_entity
  end

  test "should destroy club" do
    result = Result.new(value: @club)

    @clubs_service.stubs(:delete).with(@club.id.to_s).returns(result)

    delete club_url(@club), as: :json

    assert_nil response.parsed_body["data"]
    assert_response :no_content
  end

  test "should not destroy club when it does not exist" do
    message = "Club was not found"
    failure = ServiceFailure::NotFoundFailure.new(message)
    result = Result.new(failure:)
    @clubs_service.stubs(:delete).with(@club.id.to_s).returns(result)
    api_error = ApiError.new(ApiCode::NOT_FOUND, message)
    expected = [api_error]

    delete club_url(@club), as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :not_found
  end

  test "should not destroy club when something goes wrong" do
    message = "Club was not deleted"
    failure = ServiceFailure::ServerFailure.new(message)
    result = Result.new(failure:)
    @clubs_service.stubs(:delete).with(@club.id.to_s).returns(result)
    api_error = ApiError.new(ApiCode::SERVER_ERROR, message)
    expected = [api_error]

    delete club_url(@club), as: :json

    assert_equal response.parsed_body["errors"], expected.as_json
    assert_response :unprocessable_entity
  end
end
