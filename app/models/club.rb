# frozen_string_literal: true

# == Schema Information
#
# Table name: clubs
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  description     :string(255)
#  owner_id        :bigint           not null
#  players_count   :integer          default(0), not null
#  cover_image_url :string(255)
#
class Club < ApplicationRecord
  has_many :memberships, dependent: :delete_all
  has_many :players, through: :memberships
  belongs_to :owner, class_name: "Player"

  validates_presence_of :name, message: "can't be blank"
  validates :description, length: { maximum: 255 }
  validates :cover_image_url, http_url: true

  before_save :set_players_count

  private

  def set_players_count
    self.players_count = players.length
  end
end
