# frozen_string_literal: true

class AddOwnerToClub < ActiveRecord::Migration[7.0]
  def change
    add_reference :clubs, :owner, null: false, foreign_key: { to_table: :players }
  end
end
