class ClubsService
  def club(id)
    club = Club.find_by(id: id)

    if club
      Result.new(value: club)
    else
      failure = ServiceFailure::NotFoundFailure.new('Club was not found')
      Result.new(failure: failure)
    end
  end

  def create(params)
    club = Club.new(params)

    if club.save
      Result.new(value: club)
    else
      failure = ServiceFailure::ValidationFailure.new('Club was not created')
      Result.new(failure: failure)
    end
  end

  def update(id, params)
    club = Club.find_by(id: id)

    if club.update(params)
      Result.new(value: club)
    else
      failure = ServiceFailure::ValidationFailure.new('Club was not updated')
      Result.new(failure: failure)
    end
  end

  def delete(id)
    begin
      Result.new(value: Club.destroy(id))
    rescue ActiveRecord::RecordNotFound
      failure = ServiceFailure::NotFoundFailure.new('Club was not found')
      Result.new(failure: failure)
    rescue => exception
      failure = ServiceFailure::ServerFailure.new('Club was not deleted')
      Result.new(failure: failure)
    end
  end
end
