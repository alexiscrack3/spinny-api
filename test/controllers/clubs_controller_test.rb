require "test_helper"

class ClubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club = clubs(:one)
  end

  test "should get index" do
    get clubs_url, as: :json
    assert_response :success
  end

  test "should create club" do
    assert_difference("Club.count") do
      post clubs_url, params: { club: { name: @club.name } }, as: :json
    end

    assert_response :created
  end

  test "should show club" do
    get club_url(@club), as: :json
    assert_response :success
  end

  test "should update club" do
    patch club_url(@club), params: { club: { name: @club.name } }, as: :json
    assert_response :success
  end

  test "should destroy club" do
    assert_difference("Club.count", -1) do
      delete club_url(@club), as: :json
    end

    assert_response :no_content
  end
end
