FactoryBot.define do
  factory :user do
    password { 'password' }
<<<<<<< HEAD
    email { Faker::Internet.email }
=======
    email { 'user@example.com' }
>>>>>>> 5803786 (add model factories)
  end
end
