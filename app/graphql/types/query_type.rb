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
      description: "An example field added by the generator"

    def test_field
      "Hello World!"
    end

    field :players,
          [Types::PlayerType],
          null: false,
      description: "List of players"

    field :player,
          resolver: Resolvers::PlayerResolver
      description: "Get a player",

    field :clubs,
          resolver: Resolvers::ClubsResolver
      description: "List of clubs",

    field :club, description: "Get a club", resolver: Resolvers::ClubResolver

    def players
      Player.all
    end
  end
end
