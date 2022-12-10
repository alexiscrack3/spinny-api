# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Game.delete_all
Membership.delete_all
Player.delete_all
Club.delete_all

20.times do
  Player.create!(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    email: Faker::Internet.unique.email,
  )
end

5.times { Club.create!(name: Faker::Team.name) }

Club.first.players << Player.first

Club.first.players << Player.last

1.times { Game.create!(winner: Membership.first, loser: Membership.last) }
