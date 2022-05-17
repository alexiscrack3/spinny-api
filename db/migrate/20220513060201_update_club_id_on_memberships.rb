# frozen_string_literal: true

class UpdateClubIdOnMemberships < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :memberships, :clubs
    add_foreign_key :memberships, :clubs, on_delete: :cascade
  end
end
