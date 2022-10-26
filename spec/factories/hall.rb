FactoryBot.define do
  factory :hall do
    name { Faker::Color.color_name }
    capacity { 50 }
  end
end
