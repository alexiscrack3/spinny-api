class AddImagePathToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :image_path, :string
  end
end
