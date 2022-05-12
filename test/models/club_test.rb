# frozen_string_literal: true

require "test_helper"

class ClubTest < ActiveSupport::TestCase
  def setup
    @club = Club.new(name: Faker::Team.name)
  end

  test "club should be valid" do
    assert @club.valid?
  end

  test "club should not valid when name is nil" do
    @club.name = nil
    assert_not @club.valid?
  end

  test "club should not valid when name is empty" do
    @club.name = ""
    assert_not @club.valid?
  end

  test "club should not valid when name is blank" do
    @club.name = " "
    assert_not @club.valid?
  end
end
