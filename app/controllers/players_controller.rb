class PlayersController < ApplicationController
  before_action :set_player, only: %i[show]

  def initialize
    @players_service = PlayersService.new
  end

  # GET /players
  def index
    result = @players_service.players

    render json: ApiDocument.new(data: result.value)
  end

  # GET /players/1
  def show
    if @result.success?
      render json: ApiDocument.new(data: @result.value)
    else
      handle_error(@result.failure)
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
    result = @players_service.update(params[:id], player_params)

    if result.success?
      render json: ApiDocument.new(data: result.value)
    else
      handle_error(result.failure)
    end
  end

  # DELETE /players/1
  def destroy
    result = @players_service.delete(params[:id])

    if result.success?
      render json: ApiDocument.new(data: result.value), status: :no_content
    else
      handle_error(result.failure)
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

  def handle_error(error)
    case error
    when ServiceFailure::NotFoundFailure
      apiError = ApiError.new(ApiCode::NOT_FOUND, error.message)
      render json: ApiDocument.new(errors: [apiError]), status: :not_found
    else
      apiError = ApiError.new(ApiCode::SERVER_ERROR, error.message)
      render json: ApiDocument.new(errors: [apiError]),
             status: :unprocessable_entity
    end
  end
end