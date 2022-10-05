FactoryBot.define do
  factory :screening do
    movie
    hall
    start_time { Date.today + 3.days }
  end
end
