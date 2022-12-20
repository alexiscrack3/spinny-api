# frozen_string_literal: true

# == Schema Information
#
# Table name: clubs
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string(255)
#
class Club < ApplicationRecord
  has_many :memberships, dependent: :delete_all
  has_many :players, through: :memberships

  validates_presence_of :name, message: "can't be blank"
  validates :description, length: { maximum: 255 }
end
