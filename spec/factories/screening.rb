FactoryBot.define do
  factory :screening do
<<<<<<< HEAD
    movie
    hall
=======
    movie_id { 1 }
    hall_id { 1 }
>>>>>>> 5803786 (add model factories)
    start_time { Date.today + 3.days }
  end
end
