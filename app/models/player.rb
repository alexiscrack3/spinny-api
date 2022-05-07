# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string(255)      not null
#
class Player < ApplicationRecord
  validates_presence_of :first_name, message: "can't be blank"
  validates :last_name, presence: true
end
