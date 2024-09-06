# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

5.times do
  password = Faker::Internet.password(min_length: 6)
  user = User.create!(
    name: Faker::Lorem.characters(number:5),
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password
    )
end

31.times do
  work = Work.create!(
    title: Faker::Lorem.characters(number: 10),
    introduction: Faker::Lorem.characters(number: 30),
    music_file: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('/spec/fixtures/music_file/guitar_solo.wav')), filename: "guitar_solo.wav")
    )
end