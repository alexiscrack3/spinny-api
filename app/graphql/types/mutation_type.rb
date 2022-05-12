# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :player_delete, mutation: Mutations::PlayerDelete
    field :player_update, mutation: Mutations::PlayerUpdate
    field :player_create, mutation: Mutations::PlayerCreate

    # TODO: remove me
    field :test_field,
          String,
          null: false,
      description: "An example field added by the generator"

    def test_field
      "Hello World"
    end
  end
end
