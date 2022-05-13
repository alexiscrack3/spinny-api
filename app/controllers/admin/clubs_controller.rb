# frozen_string_literal: true

module Admin
  class ClubsController < ApplicationController
    def initialize
      super
      @clubs_service = ClubsService.new
    end

    # GET /clubs
    def index
      result = @clubs_service.clubs

      render json: ApiDocument.new(data: result.value)
    end
  end
end
