# frozen_string_literal: true

# == Schema Information
#
# Table name: clubs
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Club < ApplicationRecord
  has_and_belongs_to_many :players

  validates_presence_of :name, message: "can't be blank"
end