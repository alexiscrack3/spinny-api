class PlayersController < ApplicationController
  before_action :set_player, only: %i[show]

  def initialize
    @players_service = PlayersService.new
  end

  # GET /players
  def index
    result = @players_service.players

    render json: ApiDocument.new(data: result.data)
  end

  # GET /players/1
  def show
    if @result.success?
      render json: ApiDocument.new(data: @result.data)
    else
      render json: ApiDocument.new(errors: @result.errors), status: :not_found
    end
  end

  # POST /players
  def create
    result = @players_service.create(player_params)

    if result.success?
      render json: ApiDocument.new(data: result.data),
             status: :created,
             location: result.data
    else
      render json: ApiDocument.new(errors: result.errors),
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  def update
    result = @players_service.update(params[:id], player_params)

    if result.success?
      render json: ApiDocument.new(data: result.data)
    else
      render json: ApiDocument.new(errors: result.errors),
             status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    result = @players_service.delete(params[:id])

    if result.success?
      render json: ApiDocument.new(data: result.data), status: :no_content
    else
      render json: ApiDocument.new(errors: result.errors),
             status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @result = @players_service.player(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def player_params
    params.require(:player).permit(:first_name, :last_name)
  end
end
