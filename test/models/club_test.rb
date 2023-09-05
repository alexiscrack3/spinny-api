# frozen_string_literal: true

require "test_helper"

class ClubTest < ActiveSupport::TestCase
  def setup
    @club = Club.new(
      name: Faker::Team.name,
      description: nil,
      cover_image_path: nil,
      owner: players(:admin),
      players_count: 0,
      players: [],
    )
  end

  test "club should be valid" do
    assert @club.valid?
  end

  test "club should not be valid when name is nil" do
    @club.name = nil
    assert_not @club.valid?
  end

  test "club should not be valid when name is empty" do
    @club.name = ""
    assert_not @club.valid?
  end

  test "club should not be valid when name is blank" do
    @club.name = " "
    assert_not @club.valid?
  end

  test "club should not be valid when description exceeds 255 characters" do
    @club.description = "a" * 256
    assert_not @club.valid?
  end

  test "club should set players_count when a club is saved" do
    @club.players << players(:free_agent)
    @club.save

    assert_equal @club.players_count, 1
  end
end
