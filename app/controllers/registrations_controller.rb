# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def sign_up(resource_name, resource)
    # by pass the session store on the default implementation
    sign_in resource, store: false
  end

  private

  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end

  def register_success
    render json: ApiDocument.new(data: current_player), status: :ok
  end

  def register_failed
    error = ApiError.new(ApiCode::INTERNAL_SERVER, "Something went wrong")
    render json: ApiDocument.new(errors: [error]), status: :unprocessable_entity
  end
end
