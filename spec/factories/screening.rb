FactoryBot.define do
  factory :screening do
    movie
    hall
    start_time { Time.current + 30.minutes }
  end
end
