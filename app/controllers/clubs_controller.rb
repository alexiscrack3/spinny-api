# frozen_string_literal: true

class ClubsController < ApplicationController
  # before_action :set_club, only: %i[show update destroy]

  def initialize
    @clubs_service = ClubsService.new
  end

  # GET /clubs/1
  def show
    result = @clubs_service.club(params[:id])
    if result.success?
      render json: ApiDocument.new(data: result.value)
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
    result = @clubs_service.update(params[:id], club_params)

    if result.success?
      render json: ApiDocument.new(data: result.value)
    else
      handle_error(result.failure)
    end
  end

  # DELETE /clubs/1
  def destroy
    result = @clubs_service.delete(params[:id])

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
