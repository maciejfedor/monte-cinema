FactoryBot.define do
  factory :user do
    password { 'password' }
    email { 'user@example.com' }
  end
end
