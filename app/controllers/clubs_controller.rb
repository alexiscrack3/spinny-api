# typed: true
# frozen_string_literal: true

class ClubsController < ApplicationController
  before_action :authenticate_player!, only: [:index, :create, :show, :update, :destroy, :members, :join, :leave]

  sig { void }
  def initialize
    super
    @clubs_service = T.let(ClubsService.new, ClubsService)
  end

  # GET /clubs
  def index
    player_id = current_player&.id
    if player_id.present?
      result = @clubs_service.clubs_by_player_id(player_id)
      render json: ApiDocument.new(data: result.value)
    else
      message = "Player id is required"
      api_error = ApiError.new(ApiCode::INTERNAL_SERVER, message)
      render json: ApiDocument.new(errors: [api_error]), status: :unprocessable_entity
    end
  end

  # GET /clubs/1
  def show
    id = T.cast(params[:id], String)
    result = @clubs_service.club(id)
    if result.success?
      json = {
        include: [:owner, :players],
        except: [:owner_id],
      }
      render json: ApiDocument.new(data: result.value.as_json(json))
    else
      handle_error(result.failure)
    end
  end

  # POST /clubs
  def create
    controller_params = T.cast(params[:club], ActionController::Parameters)
    controller_params[:owner_id] = current_player&.id
    result = @clubs_service.create(club_params)

    if result.success?
      render json: ApiDocument.new(data: result.value),
        status: :created,
        location: result.value
    else
      handle_error(result.failure)
    end
  end

  # PATCH/PUT /clubs/1
  def update
    id = T.cast(params[:id], String)
    result = @clubs_service.update(id, club_params)

    if result.success?
      render json: ApiDocument.new(data: result.value)
    else
      handle_error(result.failure)
    end
  end

  # DELETE /clubs/1
  def destroy
    id = T.cast(params[:id], String)
    result = @clubs_service.delete(id)

    if result.success?
      render json: nil, status: :no_content
    else
      handle_error(result.failure)
    end
  end

  def members
    club_id = members_params[:club_id]
    result = @clubs_service.members_by_club_id(club_id)
    render json: ApiDocument.new(data: result.value)
  end

  def join
    club_id = join_params[:club_id]
    player_id = join_params[:player_id]

    result = @clubs_service.join(club_id: club_id, player_id: player_id)

    if result.success?
      render json: result, status: :created
    else
      handle_error(result.failure)
    end
  end

  def leave
    club_id = join_params[:club_id]
    player_id = join_params[:player_id]

    result = @clubs_service.leave(club_id: club_id, player_id: player_id)

    if result.success?
      render json: nil, status: :no_content
    else
      handle_error(result.failure)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_club
  #   @club = Club.find(params[:id])
  # end

  # Only allow a list of trusted parameters through.
  def club_params
    required = T.cast(params.require(:club), ActionController::Parameters)
    required.permit(
      :name,
      :description,
      :cover_image_url,
      :owner_id,
    )
  end

  def members_params
    params.permit(
      :club_id,
    )
  end

  def join_params
    params.permit(
      :club_id,
      :player_id,
    )
  end
end
