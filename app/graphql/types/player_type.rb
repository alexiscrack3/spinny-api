# frozen_string_literal: true

module Types
  class PlayerType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String
    field :last_name, String
    field :email, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :clubs, [Types::ClubType], null: false
  end
end
