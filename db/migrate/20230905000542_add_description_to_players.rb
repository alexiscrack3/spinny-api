# frozen_string_literal: true

class AddDescriptionToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :description, :string, null: true
  end
end
