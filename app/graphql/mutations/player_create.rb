# frozen_string_literal: true

module Mutations
  class PlayerCreate < BaseMutation
    description "Creates a new player"

    field :player, Types::PlayerType, null: false

    argument :player_input, Types::PlayerInputType, required: true

    def resolve(player_input:)
      player = ::Player.new(**player_input)
      unless player.save
                                          extensions: player.errors.to_hash
        raise GraphQL::ExecutionError.new "Error creating player",
      end

      { player: player, errors: [] }
    end
  end
end
