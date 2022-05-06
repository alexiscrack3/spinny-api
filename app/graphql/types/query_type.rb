module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field,
          String,
          null: false,
          description: 'An example field added by the generator'

    def test_field
      'Hello World!'
    end

    field :players,
          [Types::PlayerType],
          null: false,
          description: 'List of players'

    field :player, Types::PlayerType, null: true, description: 'A player' do
      argument :id, ID, required: true
    end

    def players
      Player.all
    end

    def player(id:)
      Player.find(id)
    end
  end
end
