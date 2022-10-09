require 'rails_helper'

RSpec.describe 'Screenings', type: :request do
  subject(:screening) { create(:screening, movie_id: movie.id, hall_id: hall.id) }
  let(:movie) { create(:movie) }
  let(:hall) { create(:hall) }

  before do
    hall
    movie
  end

  describe 'GET api/v1/screenings/screening_id' do
    before { screening }

    it 'returns succesful response' do
      get api_v1_screening_url(screening)
      expect(response).to have_http_status(200)
    end
  end
end
