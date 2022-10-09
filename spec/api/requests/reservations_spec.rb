require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  let(:seats) { [*'10'..'13'] }
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:hall) { create(:hall) }
  let(:screening) { create(:screening, hall:, movie:, start_time: Date.current + 2.days) }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'GET api/v1/reservations/reservation_id' do
    let(:ticket) { build(:ticket, seat: '1') }
    subject(:reservation) { create(:reservation, tickets: [ticket]) }
    it 'returns succesful response' do
      get api_v1_reservation_url(reservation), headers: auth_headers
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST api/v1/screenings/screening_id/reservations' do
    let(:params) do
      {
        reservations: {
          seats: %w[10 20]
        }
      }
    end
    it 'returns succesful response' do
      post("/api/v1/screenings/#{screening.id}/reservations", params:, headers: auth_headers)
      expect(response).to have_http_status(201)
    end
  end
end
