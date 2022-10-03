FactoryBot.define do
  factory :screening do
    movie_id { 1 }
    hall_id { 1 }
    start_time { Date.today + 3.days }
  end
end
