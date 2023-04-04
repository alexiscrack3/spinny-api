# frozen_string_literal: true

module ServiceFailure
  class ArgumentNull < Failure; end

  class DuplicateKey < Failure; end

  class RecordValidation < Failure; end

  class NotFound < Failure; end

  class InternalServer < Failure; end
end
