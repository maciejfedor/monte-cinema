require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET api/v1/movies' do
    context 'when no movies in db' do
      it 'works and return status 200' do
        get api_v1_movies_url
        expect(response.status).to eq(200)
      end

      it 'returns proper json response' do
        get api_v1_movies_url
        expect(JSON.parse(response.body).deep_symbolize_keys[:data]).to eq([])
      end
    end
    context 'when movies in db' do
      before { create_list(:movie, 5) }
      it 'works and return status 200' do
        get api_v1_movies_url
        expect(response).to have_http_status(200)
      end

      it 'returns proper json response' do
        get api_v1_movies_url
        expect(JSON.parse(response.body).deep_symbolize_keys[:data].count).to eq(5)
      end
    end
  end

  describe 'GET api/v1/movies/movie_id' do
    let(:movie) { create(:movie) }
    let(:screening) {create(:screening, movie_id: movie.id)}
    let(:movie_attr) do
      {
        title: movie.title,
        duration: movie.duration
      }
    end

    before do
      movie
      screening
    end

    context 'when movie is found' do
      it 'returns succesful response' do
        get api_v1_movie_url(movie)
        expect(response).to have_http_status(200)
      end

      it 'returns movie with proper id' do
        get api_v1_movie_url(movie)
        expect(JSON.parse(response.body).deep_symbolize_keys[:data][:id]).to eq(movie.id.to_s)
      end

      it 'returns correct movie attributes' do
        get api_v1_movie_url(movie)
        expect(JSON.parse(response.body).deep_symbolize_keys[:data][:attributes]).to eq(movie_attr)
      end

      it 'returns count of screenings for a given movie' do
        get api_v1_movie_url(movie)
        debugger
        expect(JSON.parse(response.body).deep_symbolize_keys
        [:data][:relationships][:screenings][:meta][:count]).to eq(1)
      end
    end

    context 'when movie does not exist' do
      it 'returns error' do
        get api_v1_movie_url(0)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
