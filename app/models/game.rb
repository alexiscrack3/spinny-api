# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :winner, class_name: "Membership"
  belongs_to :loser, class_name: "Membership"
end
