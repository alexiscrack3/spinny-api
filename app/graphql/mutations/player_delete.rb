# frozen_string_literal: true

module Mutations
  class PlayerDelete < BaseMutation
    description 'Deletes a player by ID'

    field :player, Types::PlayerType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      player = ::Player.find(id)
      unless player.destroy
        raise GraphQL::ExecutionError.new 'Error deleting player',
                                          extensions: player.errors.to_hash
      end

      { player: player, errors: [] }
    end
  end
end
