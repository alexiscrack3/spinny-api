module ServiceFailure
  class ValidationFailure < Failure
  end

  class NotFoundFailure < Failure
  end

  class ServerFailure < Failure
  end
end
