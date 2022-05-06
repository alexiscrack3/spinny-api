# frozen_string_literal: true

module Types
  class PlayerInputType < Types::BaseInputObject
    argument :first_name, String, required: true
    argument :last_name, String, required: true
  end
end
