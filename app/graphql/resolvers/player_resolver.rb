module Resolvers
  class PlayerResolver < BaseResolver
    type Types::PlayerType, null: true

    argument :id, ID, required: true

    def resolve(id:)
      Player.find(id)
    end
  end
end
