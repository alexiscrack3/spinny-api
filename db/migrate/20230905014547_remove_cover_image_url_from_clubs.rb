class RemoveCoverImageUrlFromClubs < ActiveRecord::Migration[7.0]
  def change
    remove_column :clubs, :cover_image_url, :string
  end
end
