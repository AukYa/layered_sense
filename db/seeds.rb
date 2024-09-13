# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# 管理者ユーザーの登録
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
  admin.password_confirmation = ENV['ADMIN_PASSWORD']
end

# 投稿用エンドユーザーの登録
sampleuser = User.find_or_create_by!(email: "sample@aaa.jp") do |user|
  user.name = "sampleuser"
  user.password = "123456"
  user.password_confirmation = "123456"
end

# レスポンス用エンドユーザーの登録
Faker::Config.locale = :en
5.times do
  user = User.create!(
    name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: "123456",
    password_confirmation: "123456"
  )
end

# 閲覧用エンドユーザーの登録
testuser = User.find_or_create_by!(email: "test@aaa.jp") do |user|
  user.name = "testuser"
  user.password = "123456"
  user.password_confirmation = "123456"
end

# タグの登録
tags = %w(short inst firstwork gamemusic synth vocaloid rock cover)
tags.each{ |tag_name| Tag.find_or_create_by!(tag_name: tag_name) }

# グループの登録
Group.find_or_create_by!(title: "Rock music group") do |group|
  group.group_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/image/Rock_music_group_img.jpg"), filename: "Rock_music_group_img")
  group.introduction = "Rock music is life."
  group.owner_id = 1
end

Group.find_or_create_by!(title: "Instrumental group") do |group|
  group.group_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/image/Instrumental_group_img.jpg"), filename: "Instrumental_group_img.jpg")
  group.introduction = "I want to listen to instrumental music !!"
  group.owner_id = 1
end

# グループのメンバーシップの紐づけ
group1_user_ids = [1, 5, 6]
group1_user_ids.each{ |user_id| Membership.find_or_create_by!(group_id: 1, user_id: user_id) }

group2_user_ids = [1, 2, 3, 4]
group2_user_ids.each{ |user_id| Membership.find_or_create_by!(group_id: 2, user_id: user_id) }

# ワークの登録とタグの紐づけ
Work.find_or_create_by!(title: "short inst") do |work|
  work.music_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/music_file/short_inst.wav"), filename: "short_inst.wav")
  work.introduction = "This is \"tamamo best play\" of song in my mind."
  work.group_id = 2
  work.user_id = 1
end
tag_relationship1 = TagRelationship.find_or_create_by!(tag_id: 1, work_id: 1)
tag_relationship2 = TagRelationship.find_or_create_by!(tag_id: 2, work_id: 1)

Work.find_or_create_by!(title: "none title") do |work|
  work.music_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/music_file/none_title.wav"), filename: "none_title.wav")
  work.introduction = "Instrumental music is interesting."
  work.group_id = 2
  work.user_id = 1
end
tag_relationship1 = TagRelationship.find_or_create_by!(tag_id: 2, work_id: 2)

Work.find_or_create_by!(title: "My first music") do |work|
  work.music_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/music_file/My_first_work.wav"), filename: "My_first_work.wav")
  work.introduction = "Please be gentle."
  work.group_id = 2
  work.user_id = 1
end
tag_relationship1 = TagRelationship.find_or_create_by!(tag_id: 2, work_id: 3)
tag_relationship2 = TagRelationship.find_or_create_by!(tag_id: 3, work_id: 3)

Work.find_or_create_by!(title: "game music") do |work|
  work.music_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/music_file/game_music.wav"), filename: "game_music.wav")
  work.introduction = "My favorite game."
  work.group_id = 2
  work.user_id = 1
end
tag_relationship1 = TagRelationship.find_or_create_by!(tag_id: 2, work_id: 4)
tag_relationship2 = TagRelationship.find_or_create_by!(tag_id: 4, work_id: 4)
tag_relationship3 = TagRelationship.find_or_create_by!(tag_id: 5, work_id: 4)

Work.find_or_create_by!(title: "short song") do |work|
  work.music_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/music_file/short_song.wav"), filename: "short_song.wav")
  work.introduction = "This is a vocaloid song."
  work.user_id = 1
end
tag_relationship1 = TagRelationship.find_or_create_by!(tag_id: 1, work_id: 5)
tag_relationship2 = TagRelationship.find_or_create_by!(tag_id: 6, work_id: 5)

Work.find_or_create_by!(title: "Rock cover") do |work|
  work.music_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/music_file/Rock_cover.wav"), filename: "Rock_cover.wav")
  work.introduction = "I tried covering it with a rock arrangement."
  work.group_id = 1
  work.user_id = 1
end
tag_relationship3 = TagRelationship.find_or_create_by!(tag_id: 7, work_id: 6)
tag_relationship3 = TagRelationship.find_or_create_by!(tag_id: 8, work_id: 6)

# 各ワークのコメントの投稿
comments = ["Nice work!!", "That's interesting.", "I learned a lot.", "Awesome! Thank you!!", "I respect you."]

(1..6).each do |work_id|
  3.times do
    Comment.create!(
      user_id: rand(2..6),
      work_id: work_id,
      content: comments.sample
      )
  end
end

# 各グループのチャットの投稿
chats = ["Nice work!!", "That's interesting.", "I learned a lot.", "Awesome! Thank you!!", "I respect you."]

3.times do
  Chat.create!(
    user_id: rand(2..4),
    group_id: 2,
    chat: chats.sample
    )
end

3.times do
  Chat.create!(
    user_id: rand(5..6),
    group_id: 1,
    chat: chats.sample
    )
end

# クエスチョンの登録
Question.find_or_create_by!(title: "About my guitar solo") do |question|
  question.attachments_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/music_file/guitar_solo.wav"), filename: "guitar_solo.wav")
  question.content = "please sound review."
  question.user_id = 1
end

Question.find_or_create_by!(title: "Improvements to my work environment") do |question|
  question.attachments_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/image/work_environments_question_img.jpg"), filename: "work_environments_question_img.jpg")
  question.content = "Please give me some opinions. \n" + "I'd especially like some feedback on speaker placement."
  question.user_id = 1
end

# 各クエスチョンのアンサーの登録
Answer.find_or_create_by!(content: "The atmosphere of the sound is very good.") do |answer|
  answer.user_id = 5
  answer.question_id = 1
end
Answer.find_or_create_by!(content: "The octave playing is very attractive, but it might be nice to hear some more tricks. \n" + "Here's how I would play it.Please try it out.") do |answer|
  answer.attachments_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/music_file/guitar_solo2.wav"), filename: "guitar_solo2.wav")
  answer.user_id = 6
  answer.question_id = 1
  answer.is_best_answer = true
end

Answer.find_or_create_by!(content: "It looks very neat and easy to use. My advice would be to try putting a midi keyboard on it.") do |answer|
  answer.attachments_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/image/midi_keyboard.jpg"), filename: "midi_keyboard.jpg")
  answer.user_id = 3
  answer.question_id = 2
end
Answer.find_or_create_by!(content: "I'll show you my setup for reference. My advice would be to place the speakers away from the walls if possible. \n" + "But most importantly, make sure it makes you feel good.") do |answer|
  answer.attachments_file = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/spec/fixtures/image/music_desk_answer.jpg"), filename: "music_desk_answer.jpg")
  answer.user_id = 2
  answer.question_id = 2
  answer.is_best_answer = true
end