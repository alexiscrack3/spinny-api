# frozen_string_literal: true

class AddCoverImageUrlToClub < ActiveRecord::Migration[7.0]
  def change
    add_column :clubs, :cover_image_url, :string, null: true, default: nil
  end
end
