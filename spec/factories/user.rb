FactoryBot.define do
  factory :user do
    password { 'password' }
    email { Faker::Internet.email }
  end
end
