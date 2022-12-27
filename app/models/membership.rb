# frozen_string_literal: true

# == Schema Information
#
# Table name: memberships
#
#  id         :bigint           not null, primary key
#  player_id  :bigint           not null
#  club_id    :bigint           not null
#  rating     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Membership < ApplicationRecord
  belongs_to :player
  belongs_to :club
end
