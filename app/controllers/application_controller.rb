# typed: true
# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Devise::Controllers::Helpers
  extend T::Sig

  rescue_from Pundit::NotAuthorizedError, with: :player_not_authorized

  protected

  def pundit_user
    current_player
  end

  def handle_error(error)
    case error
    when ServiceFailure::NotFound
      api_error = ApiError.new(ApiCode::NOT_FOUND, error.message)
      render json: ApiDocument.new(errors: [api_error]), status: :not_found
    else
      api_error = ApiError.new(ApiCode::INTERNAL_SERVER, error.message)
      render json: ApiDocument.new(errors: [api_error]),
        status: :unprocessable_entity
    end
  end

  private

  def player_not_authorized
    render json: ApiDocument.new(errors: []),
      status: :forbidden
  end
end
