require 'dotenv'
require 'rest-client'
require 'json'
require 'uri'
Dotenv.load

SEARCH_URI = 'https://api.themoviedb.org/3/search/movie?api_key='
MOVIES_URI = 'https://api.themoviedb.org/3/movie/now_playing?api_key='
POSTER_URI = 'https://image.tmdb.org/t/p/w500'

module ApiExternal
class MoviesDataController < ApplicationController





def api_key
  ENV['API_KEY']
end

def movie_ids

end


def get_movie(title)
  url = "#{SEARCH_URI}#{api_key}&query=#{title}"
  url = CGI.escape(url) unless url.ascii_only?
  URI.parse(url)
  response = RestClient.get(url)
  JSON.parse(response.body).deep_symbolize_keys
end

def movie_poster(title)
movies = get_movie(title)[:results]
poster_path = ""
movies.each do |movie|

  poster_path = (movie[:title] == title ? movie[:poster_path] : nil)

end

"#{POSTER_URI}#{poster_path}" if poster_path
end

def movies(page)
  response = RestClient.get("#{MOVIES_URI}#{api_key}&page=#{page}")
  JSON.parse(response.body).deep_symbolize_keys
end

# def response
#   @response ||= get_movie
# end





end
end