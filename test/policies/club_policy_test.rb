# frozen_string_literal: true

require "test_helper"

class ClubPolicyTest < ActiveSupport::TestCase
  test "index? should return true when player is admin" do
    player = players(:admin)
    club_policy = ClubPolicy.new(player, nil)

    actual = club_policy.index?

    assert actual
  end

  test "index? should return false when player is guest" do
    player = players(:free_agent)
    club_policy = ClubPolicy.new(player, nil)

    actual = club_policy.index?

    refute actual
  end
end
