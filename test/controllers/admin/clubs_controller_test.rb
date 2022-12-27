# frozen_string_literal: true

require "test_helper"

module Admin
  class ClubsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @club = clubs(:club_with_players)
    end

    test "should show clubs when they exist" do
      clubs = [@club]
      result = Result.new(value: clubs)
      ClubsService
        .any_instance
        .stubs(:clubs)
        .returns(result)

      get admin_clubs_url, as: :json

      assert_equal clubs.as_json, response.parsed_body["data"]
      assert_response :success
    end

    test "should not show clubs when they do not exist" do
      result = Result.new(value: [])
      ClubsService
        .any_instance
        .stubs(:clubs)
        .returns(result)

      get admin_clubs_url, as: :json

      assert_equal [], response.parsed_body["data"]
      assert_response :success
    end
  end
end
