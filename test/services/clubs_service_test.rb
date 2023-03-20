# typed: true
# frozen_string_literal: true

require "test_helper"

class ClubsServiceTest < ActiveSupport::TestCase
  extend T::Sig

  def setup
    @clubs_service = ClubsService.new
  end

  test "should get all clubs" do
    result = @clubs_service.clubs
    assert_equal Club.all, result.value
  end

  test "should get all clubs by player id" do
    player = players(:player_with_club)
    club_a = clubs(:club_with_players)
    club_b = clubs(:another_club_with_players)
    club_b.update_attribute(:created_at, club_a.created_at + 1.day)

    result = @clubs_service.clubs_by_player_id(player.id)

    assert_equal [club_a, club_b], result.value
  end

  test "should get club by id" do
    club = clubs(:club_with_players)
    result = @clubs_service.club(club.id)
    assert_equal club, result.value
  end

  test "should not get club by id when id does not exist" do
    expected = ServiceFailure::NotFoundFailure.new("Club was not found")

    result = @clubs_service.club(-1)

    assert_nil result.value
    assert_equal expected, result.failure
  end

  test "should create club" do
    owner = players(:admin)
    params = {
      club: {
        name: Faker::Team.name,
        description: Faker::Lorem.sentence,
        cover_image_url: Faker::Avatar.image,
        owner_id: owner.id,
      },
    }
    club_params = club_params(params)

    assert_difference("Club.count", 1) do
      result = @clubs_service.create(club_params)

      assert_equal club_params[:name], result.value.name
      assert_equal club_params[:description], result.value.description
      assert_equal club_params[:cover_image_url], result.value.cover_image_url
      assert_equal club_params[:owner_id], result.value.owner_id
    end
  end

  test "should not create club when it is not valid" do
    club_params = ActionController::Parameters.new
    expected = ServiceFailure::ValidationFailure.new("Club was not created")

    result = @clubs_service.create(club_params)

    assert_equal expected, result.failure
  end

  test "should not create club when membership was not saved" do
    owner = players(:admin)
    params = {
      club: {
        name: Faker::Team.name,
        description: Faker::Lorem.sentence,
        cover_image_url: Faker::Avatar.image,
        owner_id: owner.id,
      },
    }
    club_params = club_params(params)
    expected = ServiceFailure::ValidationFailure.new("Membership was not created")
    membership = mock.tap { |m| m.stubs(:save).returns(false) }
    Membership
      .stubs(:new)
      .returns(membership)

    result = @clubs_service.create(club_params)

    assert_equal expected, result.failure
  end

  test "should update club" do
    club = clubs(:club_with_players)
    owner = players(:admin)
    params = {
      club: {
        name: Faker::Team.name,
        description: Faker::Lorem.sentence,
        cover_image_url: Faker::Avatar.image,
        owner_id: owner.id,
      },
    }
    club_params = club_params(params)

    result = @clubs_service.update(club.id, club_params)

    assert_equal club.id, result.value.id
    assert_equal club_params[:name], result.value.name
    assert_equal club_params[:description], result.value.description
    assert_equal club_params[:owner_id], result.value.owner_id
  end

  test "should not update club when it is not valid" do
    club = clubs(:club_with_players)
    params = {
      club: {
        name: nil,
        owner_id: nil,
      },
    }
    club_params = club_params(params)
    expected = ServiceFailure::ValidationFailure.new("Club was not updated")

    result = @clubs_service.update(club.id, club_params)

    assert_equal expected, result.failure
  end

  test "should delete club" do
    club = clubs(:club_with_players)

    assert_difference("Club.count", -1) do
      result = @clubs_service.delete(club.id)

      assert_equal club, result.value
    end
  end

  test "should not delete club when it does not exist" do
    expected = ServiceFailure::NotFoundFailure.new("Club was not found")

    result = @clubs_service.delete(-1)

    assert_equal expected, result.failure
  end

  test "should not delete club when something goes wrong" do
    club = clubs(:club_with_players)
    expected = ServiceFailure::ServerFailure.new("Club was not deleted")
    Club
      .stubs(:destroy)
      .with(club.id)
      .raises(StandardError, "This is an exception")

    result = @clubs_service.delete(club.id)

    assert_equal expected, result.failure
  end

  test "should add player to club when player has not joined yet" do
    club = clubs(:empty_club)
    player = players(:free_agent)

    assert_difference("Membership.count", 1) do
      result = @clubs_service.join(club_id: club.id, player_id: player.id)
      assert_equal club.id, result.value.club_id
      assert_equal player.id, result.value.player_id
    end
  end

  test "should not add player to club when membership was not saved" do
    club = clubs(:empty_club)
    player = players(:free_agent)
    expected = ServiceFailure::ServerFailure.new("Membership was not created")
    membership = mock.tap { |m| m.stubs(:save).returns(false) }
    Membership
      .stubs(:new)
      .returns(membership)

    assert_difference("Membership.count", 0) do
      result = @clubs_service.join(club_id: club.id, player_id: player.id)
      assert_equal expected, result.failure
    end
  end

  test "should not add player to club when club id is nil" do
    player = players(:player_with_club)
    expected = ServiceFailure::ArgumentNullFailure.new("Club id is null")

    assert_difference("Membership.count", 0) do
      result = @clubs_service.join(club_id: nil, player_id: player.id)
      assert_equal expected, result.failure
    end
  end

  test "should not add player to club when player id is nil" do
    club = clubs(:empty_club)
    expected = ServiceFailure::ArgumentNullFailure.new("Player id is null")

    assert_difference("Membership.count", 0) do
      result = @clubs_service.join(club_id: club.id, player_id: nil)
      assert_equal expected, result.failure
    end
  end

  test "should not add player to club when player has already joined" do
    club = clubs(:club_with_players)
    player = players(:player_with_club)
    expected = ServiceFailure::DuplicateKeyFailure.new("Club id and Player id already exists")

    assert_difference("Membership.count", 0) do
      result = @clubs_service.join(club_id: club.id, player_id: player.id)
      assert_equal expected, result.failure
    end
  end

  test "should remove player from club when player has already joined" do
    club = clubs(:club_with_players)
    player = players(:player_with_club)

    assert_difference("Membership.count", -1) do
      result = @clubs_service.leave(club_id: club.id, player_id: player.id)
      assert_nil result.value
    end
  end

  test "should not remove player from club when club id is nil" do
    player = players(:player_with_club)
    expected = ServiceFailure::ArgumentNullFailure.new("Club id is null")

    assert_difference("Membership.count", 0) do
      result = @clubs_service.leave(club_id: nil, player_id: player.id)
      assert_equal expected, result.failure
    end
  end

  test "should not remove player from club when player id is nil" do
    club = clubs(:club_with_players)
    expected = ServiceFailure::ArgumentNullFailure.new("Player id is null")

    assert_difference("Membership.count", 0) do
      result = @clubs_service.leave(club_id: club.id, player_id: nil)
      assert_equal expected, result.failure
    end
  end

  test "should not remove player from club when player has not joined yet" do
    club = clubs(:empty_club)
    player = players(:player_with_club)
    expected = ServiceFailure::NotFoundFailure.new("Membership already exists")

    assert_difference("Membership.count", 0) do
      result = @clubs_service.leave(club_id: club.id, player_id: player.id)
      assert_equal expected, result.failure
    end
  end

  private

  sig { params(params: T::Hash[String, T.untyped]).returns(ActionController::Parameters) }
  def club_params(params)
    T.cast(
      ActionController::Parameters.new(params).require(:club),
      ActionController::Parameters,
    ).permit(
      :name,
      :description,
      :owner_id,
    )
  end
end
