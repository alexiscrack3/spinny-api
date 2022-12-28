# frozen_string_literal: true

class AddPlayersCountToClub < ActiveRecord::Migration[7.0]
  def change
    add_column :clubs, :players_count, :integer, default: 0
  end
end
