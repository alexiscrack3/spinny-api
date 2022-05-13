# frozen_string_literal: true

class AddRatingToClubsPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :clubs_players, :rating, :integer, default: 0
  end
end
