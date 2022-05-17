# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :player
  belongs_to :club
end
