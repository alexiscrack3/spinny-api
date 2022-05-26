# frozen_string_literal: true

class GamesController < ApplicationController
  def initialize
    super
    @games_service = GamesService.new
  end

  # GET /games/1
  def show
    result = @games_service.game(params[:id])
    if result.success?
      render json: ApiDocument.new(data: result.value)
    else
      handle_error(result.failure)
    end
  end

  # POST /games
  def create
    result = @games_service.create(game_params)

    if result.success?
      render json: ApiDocument.new(data: result.value),
        status: :created,
        location: result.value
    else
      handle_error(result.failure)
    end
  end

  # PATCH/PUT /games/1
  def update
    result = @games_service.update(params[:id], game_params)

    if result.success?
      render json: ApiDocument.new(data: result.value)
    else
      handle_error(result.failure)
    end
  end

  # DELETE /games/1
  def destroy
    result = @games_service.delete(params[:id])

    if result.success?
      render json: ApiDocument.new(data: result.value), status: :no_content
    else
      handle_error(result.failure)
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:winner_id, :loser_id)
  end
end
