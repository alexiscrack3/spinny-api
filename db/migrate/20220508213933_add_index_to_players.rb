class AddIndexToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_index :players, :email, unique: true
  end
end
