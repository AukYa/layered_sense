FactoryBot.define do
  factory :work do
    title { Faker::Lorem.characters(number:10) }
    introduction { Faker::Lorem.characters(number:50) }
    user_id { 1 }
  end
end