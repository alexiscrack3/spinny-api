# typed: true
# frozen_string_literal: true

class ClubsController < ApplicationController
  sig { void }
  def initialize
    super
    @clubs_service = T.let(ClubsService.new, ClubsService)
  end

  # GET /clubs/1
  def show
    id = T.cast(params[:id], T.nilable(Integer))
    result = @clubs_service.club(id)
    if result.success?
      render json: ApiDocument.new(data: result.value.as_json(include: :players))
    else
      handle_error(result.failure)
    end
  end

  # POST /clubs
  def create
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
    id = T.cast(params[:id], T.nilable(Integer))
    result = @clubs_service.update(id, club_params)

    if result.success?
      render json: ApiDocument.new(data: result.value)
    else
      handle_error(result.failure)
    end
  end

  # DELETE /clubs/1
  def destroy
    id = T.cast(params[:id], T.nilable(Integer))
    result = @clubs_service.delete(id)

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
    params.require(:club).permit(:name)
  end
end
