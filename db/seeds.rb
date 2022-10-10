4.times do
  Hall.create!(name: Faker::Color.color_name, capacity: 50)
end

4.times do
  Hall.create!(name: Faker::Color.color_name, capacity: 100)
end

Hall.create!(name: Faker::Color.color_name, capacity: 200)
Hall.create!(name: Faker::Color.color_name, capacity: 20)

12.times do
  Movie.create!(title: Faker::Movie.title, duration: (60..200).to_a.sample)
end

movie_ids = Movie.pluck :id
hall_ids = Hall.pluck :id

20.times do
  Screening.create!(movie_id: movie_ids.sample, hall_id: hall_ids.sample, start_time: "#{Date.today +
    (2..30).to_a.sample.days} #{(10..20).to_a.sample}:#{[0, 15, 30].sample}")
end

4.times do |i|
  User.create!(email: "user#{i}@example.com", role: 'user', password: 'password')
end

User.create(email: 'manager@example.com', role: 'manager', password: 'password')
User.create(email: 'admin@example.com', role: 'admin', password: 'password')
