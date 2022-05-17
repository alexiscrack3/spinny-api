# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.references :winner, null: false, foreign_key: { to_table: :memberships, on_delete: :cascade }
      t.references :loser, null: false, foreign_key: { to_table: :memberships, on_delete: :cascade }

      t.timestamps
    end
  end
end
