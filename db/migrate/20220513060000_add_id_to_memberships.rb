# frozen_string_literal: true

class AddIdToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :id, :primary_key
  end
end
