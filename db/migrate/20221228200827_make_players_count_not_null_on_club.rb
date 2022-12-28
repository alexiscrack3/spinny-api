# frozen_string_literal: true

class MakePlayersCountNotNullOnClub < ActiveRecord::Migration[7.0]
  def change
    change_column_null :clubs, :players_count, false
  end
end
