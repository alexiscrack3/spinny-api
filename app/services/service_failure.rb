# frozen_string_literal: true

module ServiceFailure
  class ArgumentNull < Failure; end

  class DuplicateKeyFailure < Failure; end

  class ValidationFailure < Failure; end

  class NotFoundFailure < Failure; end

  class ServerFailure < Failure; end
end
