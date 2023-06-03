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
  devise :database_authenticatable,
    :registerable,
    :jwt_authenticatable,
    jwt_revocation_strategy: JwtDenylist

  after_initialize :set_default_role, :if => :new_record?
  before_save { self.email = email.downcase } # or email.downcase!
  has_many :memberships, dependent: :delete_all
  has_many :clubs, through: :memberships

  enum role: [:admin, :guest]

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

  def jwt_payload
    { role: self.role }
  end

  def set_default_role
    self.role = :guest
  end
end
