# frozen_string_literal: true

require "test_helper"

class ClubsServiceTest < ActiveSupport::TestCase
  def setup
    @clubs_service = ClubsService.new
  end

  test "should get all clubs" do
    result = @clubs_service.clubs
    assert_equal Club.all, result.value
  end

  test "should get all clubs by player id" do
    player = players(:one)
    club_a = clubs(:one)
    club_b = clubs(:two)
    club_b.update(created_at: club_a.created_at + 1.day)
    result = @clubs_service.clubs_by_player_id(player.id)
    assert_equal [club_a, club_b], result.value
  end

  test "should get club by id" do
    club = clubs(:one)
    result = @clubs_service.club(club.id)
    assert_equal club, result.value
  end

  test "should not get club by id when id does not exist" do
    result = @clubs_service.club(-1)
    expected = ServiceFailure::NotFoundFailure.new("Club was not found")

    assert_nil result.value
    assert_equal expected, result.failure
  end

  test "should create club" do
    club_params = { name: Faker::Team.name }

    result = @clubs_service.create(club_params)

    assert_equal club_params[:name], result.value.name
  end

  test "should not create club when it is not valid" do
    club_params = {}
    expected = ServiceFailure::ValidationFailure.new("Club was not created")

    result = @clubs_service.create(club_params)

    assert_equal expected, result.failure
  end

  test "should update club" do
    club = clubs(:one)
    club_params = { name: Faker::Team.name }

    result = @clubs_service.update(club.id, club_params)

    assert_equal club.id, result.value.id
    assert_equal club_params[:name], result.value.name
  end

  test "should not update club when it is not valid" do
    club = clubs(:one)
    club_params = { "name": nil }
    expected = ServiceFailure::ValidationFailure.new("Club was not updated")

    result = @clubs_service.update(club.id, club_params)

    assert_equal expected, result.failure
  end

  test "should delete club" do
    club = clubs(:one)

    result = @clubs_service.delete(club.id)

    assert_equal club, result.value
  end

  test "should not delete club when it does not exist" do
    expected = ServiceFailure::NotFoundFailure.new("Club was not found")

    result = @clubs_service.delete(-1)

    assert_equal expected, result.failure
  end

  test "should not delete club when something goes wrong" do
    club = clubs(:one)
    expected = ServiceFailure::ServerFailure.new("Club was not deleted")

    Club
      .stubs(:destroy)
      .with(club.id)
      .raises(StandardError, "This is an exception")

    result = @clubs_service.delete(club.id)

    assert_equal expected, result.failure
  end
end
