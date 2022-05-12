# frozen_string_literal: true

class CreateJoinTablePlayerClub < ActiveRecord::Migration[7.0]
  def change
    create_join_table :players, :clubs do |t|
      # t.index [:player_id, :club_id]
      # t.index [:club_id, :player_id]
    end

    add_foreign_key :clubs_players, :clubs
    add_foreign_key :clubs_players, :players
  end
end
