# frozen_string_literal: true

class AddEmailToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :email, :string, null: false
  end
end
