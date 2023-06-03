class AddRoleToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :role, :integer, default: 1
  end
end
