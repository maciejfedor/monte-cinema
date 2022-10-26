FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    duration { (60..200).to_a.sample }
  end
end
