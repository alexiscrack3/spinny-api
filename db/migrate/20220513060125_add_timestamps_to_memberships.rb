# frozen_string_literal: true

class AddTimestampsToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_timestamps :memberships
  end
end
