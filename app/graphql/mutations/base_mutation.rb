module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    argument_class Types::BaseArgument
    field_class Types::BaseField

    # input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    field :errors, [String], null: true
  end
end
