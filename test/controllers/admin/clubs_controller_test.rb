# typed: true
# frozen_string_literal: true

require "test_helper"

module Admin
  class ClubsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @club = clubs(:club_with_players)
      @player = players(:admin)
    end

    test "should show clubs when player is admin and has signed in" do
      sign_in @player
      clubs = [@club]
      result = Result.new(value: clubs)
      ClubsService
        .any_instance
        .stubs(:find_all)
        .returns(result)

      get admin_clubs_url, as: :json

      assert_equal clubs.as_json, response.parsed_body["data"]
      assert_response :success
    end

    test "should not show clubs when player has not signed in" do
      get admin_clubs_url, as: :json

      assert_response :unauthorized
    end

    test "should not show clubs when player is admin and clubs are empty" do
      sign_in @player
      result = Result.new(value: [])
      ClubsService
        .any_instance
        .stubs(:find_all)
        .returns(result)

      get admin_clubs_url, as: :json

      assert_empty response.parsed_body["data"]
      assert_response :success
    end

    test "should not show clubs when player is guest" do
      player = players(:free_agent)
      sign_in player

      get admin_clubs_url, as: :json

      assert_nil response.parsed_body["data"]
      assert_response :forbidden
    end
  end
end
