# typed: true
# frozen_string_literal: true

class ClubsService < ApplicationService
  sig { returns(Result[T::Array[Club]]) }
  def clubs
    Result.new(value: Club.all)
  end

  sig { params(player_id: Integer).returns(Result[T::Array[Club]]) }
  def clubs_by_player_id(player_id)
    clubs = Club
      .joins(:memberships)
      .where(memberships: { player_id: player_id })
      .order(:created_at)
      .to_a
    Result.new(value: clubs)
  end

  sig { params(id: T.any(String, Integer)).returns(Result[Club]) }
  def club(id)
    club = Club
      .includes(:owner)
      .includes(:players)
      .find_by(id: id)

    if club
      Result.new(value: club)
    else
      failure = ServiceFailure::NotFound.new("Club was not found")
      Result.new(value: nil, failure: failure)
    end
  end

  sig { params(params: ActionController::Parameters).returns(Result[Club]) }
  def create(params)
    club = Club.new(params)

    if club.save
      result = join(club_id: club.id, player_id: club.owner_id)
      if result.success?
        Result.new(value: club)
      else
        Result.new(value: nil, failure: result.failure)
      end
    else
      failure = ServiceFailure::ValidationFailure.new("Club was not created")
      Result.new(value: nil, failure: failure)
    end
  end

  sig do
    params(
      id: T.any(String, Integer),
      params: ActionController::Parameters,
    ).returns(Result[Club])
  end
  def update(id, params)
    club = Club.find_by(id: id)

    if club&.update(params)
      Result.new(value: club)
    else
      failure = ServiceFailure::ValidationFailure.new("Club was not updated")
      Result.new(value: nil, failure: failure)
    end
  end

  sig { params(id: T.any(String, Integer)).returns(Result[Club]) }
  def delete(id)
    Result.new(value: Club.destroy(id))
  rescue ActiveRecord::RecordNotFound
    failure = ServiceFailure::NotFound.new("Club was not found")
    Result.new(value: nil, failure: failure)
  rescue => _
    failure = ServiceFailure::ServerFailure.new("Club was not deleted")
    Result.new(value: nil, failure: failure)
  end

  sig do
    params(
      club_id: T.nilable(T.any(String, Integer)),
    ).returns(Result[Club])
  end
  def members_by_club_id(club_id)
    players = Player
      .joins(:memberships)
      .where(memberships: { club_id: club_id })

    Result.new(value: players)
  end

  sig do
    params(
      club_id: T.nilable(T.any(String, Integer)),
      player_id: T.nilable(T.any(String, Integer)),
    ).returns(Result[Membership])
  end
  def join(club_id:, player_id:)
    if club_id.nil?
      failure = ServiceFailure::ArgumentNull.new("Club id is null")
      return Result.new(value: nil, failure: failure)
    elsif player_id.nil?
      failure = ServiceFailure::ArgumentNull.new("Player id is null")
      return Result.new(value: nil, failure: failure)
    end

    exists = Membership.exists?(club_id: club_id, player_id: player_id)
    if exists
      failure = ServiceFailure::DuplicateKey.new("Club id and Player id already exists")
      Result.new(value: nil, failure: failure)
    else
      membership = Membership.new(club_id:, player_id:)
      if membership.save
        Result.new(value: membership)
      else
        failure = ServiceFailure::ServerFailure.new("Membership was not created")
        Result.new(value: nil, failure: failure)
      end
    end
  end

  sig do
    params(
      club_id: T.nilable(T.any(String, Integer)),
      player_id: T.nilable(T.any(String, Integer)),
    ).returns(Result[T.nilable(NilClass)])
  end
  def leave(club_id:, player_id:)
    if club_id.nil?
      failure = ServiceFailure::ArgumentNull.new("Club id is null")
      return Result.new(value: nil, failure: failure)
    elsif player_id.nil?
      failure = ServiceFailure::ArgumentNull.new("Player id is null")
      return Result.new(value: nil, failure: failure)
    end

    exists = Membership.exists?(club_id: club_id, player_id: player_id)
    if exists
      Membership.destroy_by(club_id: club_id, player_id: player_id)
      Result.new(value: nil)
    else
      failure = ServiceFailure::NotFound.new("Membership already exists")
      Result.new(value: nil, failure: failure)
    end
  end
end
