4.times do
  Hall.create!(name: Faker::Coffee.blend_name, capacity: 50)
end

4.times do
  Hall.create!(name: Faker::Coffee.blend_name, capacity: 100)
end

Hall.create!(name: Faker::Coffee.blend_name, capacity: 200)
Hall.create!(name: Faker::Coffee.blend_name, capacity: 20)


def page_number
  (1..98).to_a.sample
end

def movie_number
  (1..19).to_a.sample
end

def movies
  ApiExternal::MoviesDataController.new.movies(page_number)
end

20.times do
  title = movies[:results][movie_number][:title]
  poster = movies[:results][movie_number][:poster_path]
  Movie.create!(title: title, duration: (60..200).to_a.sample, poster: poster)
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
