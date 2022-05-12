require "test_helper"

class ClubsServiceTest < ActiveSupport::TestCase
  def setup
    @clubs_service = ClubsService.new
  end

  test "should get club by id" do
    club = clubs(:one)
    result = @clubs_service.club(club.id)
    assert_equal result.value, club
  end

  test "should not get club by id when id does not exist" do
    result = @clubs_service.club(-1)
    expected = ServiceFailure::NotFoundFailure.new("Club was not found")

    assert_nil result.value
    assert_equal result.failure, expected
  end

  test "should create club" do
    club_params = { name: Faker::Team.name }

    result = @clubs_service.create(club_params)

    assert_equal result.value.name, club_params[:name]
  end

  test "should not create club when it is not valid" do
    club_params = {}
    expected = ServiceFailure::ValidationFailure.new("Club was not created")

    result = @clubs_service.create(club_params)

    assert_equal result.failure, expected
  end

  test "should update club" do
    club = clubs(:one)
    club_params = { name: Faker::Team.name }

    result = @clubs_service.update(club.id, club_params)

    assert_equal result.value.id, club.id
    assert_equal result.value.name, club_params[:name]
  end

  test "should not update club when it is not valid" do
    club = clubs(:one)
    club_params = { "name": nil }
    expected = ServiceFailure::ValidationFailure.new("Club was not updated")

    result = @clubs_service.update(club.id, club_params)

    assert_equal result.failure, expected
  end

  test "should delete club" do
    club = clubs(:one)

    result = @clubs_service.delete(club.id)

    assert_equal result.value, club
  end

  test "should not delete club when it does not exist" do
    expected = ServiceFailure::NotFoundFailure.new("Club was not found")

    result = @clubs_service.delete(-1)

    assert_equal result.failure, expected
  end

  test "should not delete club when something goes wrong" do
    club = clubs(:one)
    expected = ServiceFailure::ServerFailure.new("Club was not deleted")

    Club
      .stubs(:destroy)
      .with(club.id)
      .raises(StandardError, "This is an exception")

    result = @clubs_service.delete(club.id)

    assert_equal result.failure, expected
  end
end
