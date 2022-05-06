# frozen_string_literal: true

module Mutations
  class PlayerCreate < BaseMutation
    description 'Creates a new player'

    argument :player_input, Types::PlayerInputType, required: true

    field :player, Types::PlayerType, null: false

    def resolve(player_input:)
      player = ::Player.new(**player_input)
      unless player.save
        raise GraphQL::ExecutionError.new 'Error creating player',
                                          extensions: player.errors.to_hash
      end

      { player: player, errors: [] }
    end
  end
end
