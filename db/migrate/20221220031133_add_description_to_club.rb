# frozen_string_literal: true

class AddDescriptionToClub < ActiveRecord::Migration[7.0]
  def change
    add_column :clubs, :description, :string
  end
end
