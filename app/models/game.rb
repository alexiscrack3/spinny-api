# frozen_string_literal: true

# == Schema Information
#
# Table name: games
#
#  id         :bigint           not null, primary key
#  winner_id  :bigint           not null
#  loser_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Game < ApplicationRecord
  belongs_to :winner, class_name: "Membership"
  belongs_to :loser, class_name: "Membership"
end
