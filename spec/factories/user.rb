FactoryBot.define do
  factory :user do
    password { 'password' }
    email { Faker::Internet.email }
    confirmed_at { Date.today }
  end
end
