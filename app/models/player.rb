# frozen_string_literal: true

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
  before_save { self.email = email.downcase } # or email.downcase!
  has_many :memberships, dependent: :delete_all
  has_many :clubs, through: :memberships

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :first_name, message: "can't be blank"
  validates :last_name, presence: true
  validates :email,
    presence: true,
    length: {
      maximum: 255,
    },
    format: {
      with: VALID_EMAIL_REGEX,
    },
    uniqueness: {
      case_sensitive: false,
    }
end
