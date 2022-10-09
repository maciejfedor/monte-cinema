require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET api/v1/movies' do
    it 'returns succesful response' do
      get api_v1_movies_url
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET api/v1/movies/movie_id' do
    let(:movie) { create(:movie) }

    before { movie }

    it 'returns succesful response' do
      get api_v1_movie_url(movie)
      expect(response).to have_http_status(200)
    end

    context 'when movie does not exist' do
      it 'returns error' do
        get api_v1_movie_url(0)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
