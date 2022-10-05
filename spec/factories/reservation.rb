FactoryBot.define do
  factory :reservation do
    screening
    status { 'booked' }
    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
