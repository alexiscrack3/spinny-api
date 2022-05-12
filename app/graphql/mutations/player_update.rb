# frozen_string_literal: true

module Mutations
  class PlayerUpdate < BaseMutation
    description "Updates a player by id"

    field :player, Types::PlayerType, null: false

    argument :id, ID, required: true
    argument :player_input, Types::PlayerInputType, required: true

    def resolve(id:, player_input:)
      player = ::Player.find(id)
      unless player.update(**player_input)
        raise GraphQL::ExecutionError.new "Error updating player",
          extensions: player.errors.to_hash
      end

      { player: player, errors: [] }
    end
  end
end
