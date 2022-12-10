# typed: true
# frozen_string_literal: true

class ClubsService < ApplicationService
  sig { returns(Result[T::Array[Club]]) }
  def clubs
    Result.new(value: Club.all)
  end

  sig { params(id: T.any(String, Integer)).returns(Result[Club]) }
  def club(id)
    club = T.let(Club.includes(:players).find_by(id: id), T.nilable(Club))

    if club
      Result.new(value: club)
    else
      failure = ServiceFailure::NotFoundFailure.new("Club was not found")
      Result.new(failure: failure)
    end
  end

  sig { params(params: T::Hash[String, T.untyped]).returns(Result[Club]) }
  def create(params)
    club = T.let(Club.new(params), Club)

    if club.save
      Result.new(value: club)
    else
      failure = ServiceFailure::ValidationFailure.new("Club was not created")
      Result.new(failure: failure)
    end
  end

  sig { params(id: T.any(String, Integer), params: T::Hash[String, T.untyped]).returns(Result[Club]) }
  def update(id, params)
    club = T.let(Club.find_by(id: id), T.nilable(Club))

    if club&.update(params)
      Result.new(value: club)
    else
      failure = ServiceFailure::ValidationFailure.new("Club was not updated")
      Result.new(failure: failure)
    end
  end

  sig { params(id: T.any(String, Integer)).returns(Result[Club]) }
  def delete(id)
    Result.new(value: Club.destroy(id))
  rescue ActiveRecord::RecordNotFound
    failure = ServiceFailure::NotFoundFailure.new("Club was not found")
    Result.new(failure: failure)
  rescue => _
    failure = ServiceFailure::ServerFailure.new("Club was not deleted")
    Result.new(failure: failure)
  end
end
