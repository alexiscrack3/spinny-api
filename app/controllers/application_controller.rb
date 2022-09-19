# typed: true
# frozen_string_literal: true

class ApplicationController < ActionController::API
  extend T::Sig

  protected

  def handle_error(error)
    case error
    when ServiceFailure::NotFoundFailure
      api_error = ApiError.new(ApiCode::NOT_FOUND, error.message)
      render json: ApiDocument.new(errors: [api_error]), status: :not_found
    else
      api_error = ApiError.new(ApiCode::SERVER_ERROR, error.message)
      render json: ApiDocument.new(errors: [api_error]),
        status: :unprocessable_entity
    end
  end
end
