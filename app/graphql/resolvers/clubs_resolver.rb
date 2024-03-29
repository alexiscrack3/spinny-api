# frozen_string_literal: true

module Resolvers
  class ClubsResolver < BaseResolver
    type [Types::ClubType], null: false

    def resolve
      Club.all
    end
  end
end
