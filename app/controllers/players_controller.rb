# typed: true
# frozen_string_literal: true

class PlayersController < ApplicationController
  before_action :authenticate_player!

  sig { void }
  def initialize
    super
    @players_service = T.let(PlayersService.new, PlayersService)
  end

  # GET /players
  def index
    result = @players_service.find_all

    render json: ApiDocument.new(data: result.value)
  end

  # GET /players/1
  def show
    id = T.cast(params[:id], String)
    result = @players_service.find(id)
    if result.success?
      render json: ApiDocument.new(data: result.value.as_json(include: :clubs))
    else
      handle_error(result.failure)
    end
  end

  # POST /players
  def create
    result = @players_service.create(player_params)

    if result.success?
      render json: ApiDocument.new(data: result.value),
        status: :created,
        location: result.value
    else
      handle_error(result.failure)
    end
  end

  # PATCH/PUT /players/1
  def update
    id = T.cast(params[:id], String)
    result = @players_service.update(id, player_params)

    if result.success?
      render json: ApiDocument.new(data: result.value)
    else
      handle_error(result.failure)
    end
  end

  # DELETE /players/1
  def destroy
    id = T.cast(params[:id], String)
    result = @players_service.delete(id)

    if result.success?
      render json: ApiDocument.new(data: result.value), status: :no_content
    else
      handle_error(result.failure)
    end
  end

  # GET /players/me
  def me
    render json: ApiDocument.new(data: current_player)
  end

  private

  # Only allow a list of trusted parameters through.
  def player_params
    controller_params = T.cast(params.require(:player), ActionController::Parameters)
    controller_params.permit(:first_name, :last_name, :email)
  end
end
