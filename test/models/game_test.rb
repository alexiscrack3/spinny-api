# frozen_string_literal: true

require "test_helper"

class GameTest < ActiveSupport::TestCase
  def setup
    @game = Game.new(
      winner: memberships(:one),
      loser: memberships(:two),
    )
  end

  test "game should be valid" do
    assert @game.valid?
  end

  test "game should not be valid when winner is not present" do
    @game.winner = nil
    refute @game.valid?
  end

  test "game should not be valid when loser is not present" do
    @game.loser = nil
    refute @game.valid?
  end
end
