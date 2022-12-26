# frozen_string_literal: true

require "test_helper"

class ClubTest < ActiveSupport::TestCase
  def setup
    @club = Club.new(
      name: Faker::Team.name,
      owner: players(:one),
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
end
