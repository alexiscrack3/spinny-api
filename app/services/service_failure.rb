# frozen_string_literal: true

module ServiceFailure
  class ArgumentNull < Failure; end

  class DuplicateKey < Failure; end

  class ValidationFailure < Failure; end

  class NotFound < Failure; end

  class ServerFailure < Failure; end
end
