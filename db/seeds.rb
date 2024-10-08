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
Club.delete_all
Player.delete_all

hero = Player.create!(
  first_name: "Alexis",
  last_name: "Ortega",
  email: "alexis@gmail.com",
  password: "123456",
  description: Faker::Lorem.sentence,
  image_path: Faker::Avatar.image(slug: "profile", size: "150x150", format: "jpg"),
)

opponent = Player.create!(
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  email: Faker::Internet.unique.email,
  password: "123456",
)

20.times do
  Player.create!(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    email: Faker::Internet.unique.email,
    password: "123456",
  )
end

10.times do
  Club.create!(
    name: Faker::Team.name,
    description: Faker::Lorem.sentence,
    owner_id: hero.id,
    players: [
      hero,
      opponent,
    ],
  )
end

20.times do
  Club.create!(
    name: Faker::Team.name,
    description: Faker::Lorem.sentence,
    owner_id: hero.id,
  )
end

Game.create!(winner: Membership.first, loser: Membership.last)
