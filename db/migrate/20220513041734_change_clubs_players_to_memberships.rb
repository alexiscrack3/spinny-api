# frozen_string_literal: true

class ChangeClubsPlayersToMemberships < ActiveRecord::Migration[7.0]
  def change
    rename_table :clubs_players, :memberships
  end
end
