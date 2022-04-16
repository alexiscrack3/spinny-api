class PlayersController < ApplicationController
  before_action :set_player, only: %i[show update destroy]

  # GET /players
  def index
    @players = Player.all

    render json: ApiDocument.new(data: @players)
  end

  # GET /players/1
  def show
    render json: ApiDocument.new(data: @player)
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    if @player.save
      render json: ApiDocument.new(data: @player),
             status: :created,
             location: @player
    else
      render json: ApiDocument.new(errors: @player.errors),
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      render json: ApiDocument.new(data: @player)
    else
      render json: ApiDocument.new(errors: @player.errors),
             status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def player_params
    params.require(:player).permit(:first_name, :last_name)
  end
end
