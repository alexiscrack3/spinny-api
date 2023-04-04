# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: ApiDocument.new(data: current_player), status: :ok
  end

  def respond_to_on_destroy
    current_player ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: ApiDocument.new(data: nil), status: :ok
  end

  def log_out_failure
    error = ApiError.new(ApiCode::INTERNAL_SERVER, "Logged out failure.")
    render json: ApiDocument.new(errors: [error]), status: :unauthorized
  end
end
