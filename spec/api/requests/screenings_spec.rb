require 'rails_helper'

RSpec.describe 'Screenings', type: :request do
  subject(:screening) { create(:screening, movie_id: movie.id, hall_id: hall.id, id: 1) }
  let(:movie) { create(:movie) }
  let(:hall) { create(:hall, capacity: 2) }
  let(:screening_attr_keys) { %i[start_time available_seats] }

  before do
    hall
    movie
  end

  describe 'GET api/v1/screenings/screening_id' do
    before { screening }

    context 'when screening is found' do
      it 'returns succesful response' do
        get api_v1_screening_url(screening)
        expect(response).to have_http_status(200)
      end

      it 'returns screening with proper id' do
        get api_v1_screening_url(screening)
        expect(JSON.parse(response.body).deep_symbolize_keys[:data][:id]).to eq(screening.id.to_s)
      end

      it 'returns correct screening attributes' do
        get api_v1_screening_url(screening)
        expect(JSON.parse(response.body).deep_symbolize_keys[:data][:attributes].keys).to eq(screening_attr_keys)
      end

      context 'when screening is not found' do
        let(:screening_id) { 500 }

        it 'returns record not found error' do
          get("/api/v1/screenings/#{screening_id}")
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
