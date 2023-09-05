class AddCoverImagePathToClubs < ActiveRecord::Migration[7.0]
  def change
    add_column :clubs, :cover_image_path, :string
  end
end
