class Player < ApplicationRecord
  validates_presence_of :first_name, message: "can't be blank"
  validates :last_name, presence: true
end
