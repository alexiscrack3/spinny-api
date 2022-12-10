# typed: true
# frozen_string_literal: true

class GamesController < ApplicationController
  sig { void }
  def initialize
    super
    @games_service = T.let(GamesService.new, GamesService)
  end

  # GET /games/1
  def show
    id = T.cast(params[:id], String)
    result = @games_service.game(id)
    if result.success?
      render json: ApiDocument.new(data: result.value.as_json(
        include: [:winner, :loser],
        except: [:winner_id, :loser_id],
      ))
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
    id = T.cast(params[:id], String)
    result = @games_service.update(id, game_params)

    if result.success?
      render json: ApiDocument.new(data: result.value)
    else
      handle_error(result.failure)
    end
  end

  # DELETE /games/1
  def destroy
    id = T.cast(params[:id], String)
    result = @games_service.delete(id)

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
