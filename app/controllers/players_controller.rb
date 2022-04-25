class PlayersController < ApplicationController
  before_action :set_player, only: %i[show]

  # GET /players
  def index
    result = PlayersService.players

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
    result = PlayersService.create(player_params)

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
    result = PlayersService.update(params[:id], player_params)

    if result.success?
      render json: ApiDocument.new(data: result.data)
    else
      render json: ApiDocument.new(errors: result.errors),
             status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    result = PlayersService.delete(params[:id])

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
    @result = PlayersService.player(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def player_params
    params.require(:player).permit(:first_name, :last_name)
  end
end
