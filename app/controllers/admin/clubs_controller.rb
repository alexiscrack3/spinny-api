# typed: true
# frozen_string_literal: true

module Admin
  class ClubsController < ApplicationController
    before_action :authenticate_player!, only: [:index]

    sig { void }
    def initialize
      super
      @clubs_service = T.let(ClubsService.new, ClubsService)
    end

    # GET /admin/clubs
    def index
      result = @clubs_service.clubs

      render json: ApiDocument.new(data: result.value)
    end
  end
end
