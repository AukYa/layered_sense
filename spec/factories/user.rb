FactoryBot.define do
  factory :user do
    id { 1 }
    name { testuser }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end