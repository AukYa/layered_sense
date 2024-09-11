# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

testuser = User.find_or_create_by!(email: "test@aaa.jp") do |user|
  user.name = "testuser"
  user.password = "123456"
  user.password_confirmation = "123456"
end

Group.find_or_create_by!(title: "Rock music group") do |group|
  group.group_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/group_image/Rock_music_group_img.jpg"), filename: "Rock_music_group_img")
  group.introduction = ""
  group.owner_id = 1
end
membership_group1 = Membership.find_or_create_by!(group_id: 1, user_id: 1)

Group.find_or_create_by!(title: "Instrumental group") do |group|
  group.group_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/group_image/Instrumental_group_img.jpg"), filename: "Instrumental_group_img.jpg")
  group.introduction = ""
  group.owner_id = 1
end
membership_group2 = Membership.find_or_create_by!(group_id: 2, user_id: 1)

# Work.find_or_create_by!(title: "short inst") do |work|
#   work.music_file = ActiveStorage::Blob.create_and_upload!(io: File.open)
#   work.introduction = ""
#   work.tag = ""
#   work.group_id = ""
# end

# 5.times do
#   password = Faker::Internet.password(min_length: 6)
#   user = User.create!(
#     name: Faker::Lorem.characters(number:5),
#     email: Faker::Internet.email,
#     password: password,
#     password_confirmation: password
#     )
#   31.times do
#     user.works.create!(
#       title: Faker::Lorem.characters(number: 10),
#       introduction: Faker::Lorem.characters(number: 30),
#       music_file: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('spec/fixtures/music_file/guitar_solo.wav')), filename: "guitar_solo.wav")
#       )
#   end
# end