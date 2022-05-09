module Resolvers
  class ClubResolver < BaseResolver
    type Types::ClubType, null: true

    argument :id, ID, required: true

    def resolve(id:)
      Club.find(id)
    end
  end
end
