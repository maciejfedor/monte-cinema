require 'rails_helper'

RSpec.describe '/reservations', type: :request do
  let(:reservation) { create(:reservation, tickets: [ticket_1], user_id: user.id) }
  let(:reservation_at_desk) { create(:reservation, tickets: [ticket_2]) }
  let(:ticket_1) { build(:ticket, seat: '1') }
  let(:ticket_2) { build(:ticket, seat: '2') }
  let(:user) { create(:user) }
  let(:manager) { create(:user, role: 'manager') }
  let(:movie) { create(:movie) }
  let(:hall) { create(:hall) }
  let(:screening) { create(:screening, hall:, movie:, start_time: Date.current + 2.days) }

  describe 'GET /reservations' do
    subject(:request) { get reservations_url }
    context 'when not logged-in' do
      let(:user) { nil }
      it 'returns status 302' do
        request
        expect(response.status).to eq(302)
      end

      it 'redirects to sign in' do
        request
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when logged-in as a regular user' do
      before do
        sign_in user
        reservation
      end

      it 'returns successful response' do
        request
        expect(response).to be_successful
      end

      it 'renders proper template' do
        request
        expect(response).to render_template(:index)
      end

      it 'shows only users reservations' do
        request
        expect(assigns(:reservations)).to eq([reservation])
      end
    end

    context 'when logged-in as a manager' do
      before do
        sign_in manager
        reservation
        reservation_at_desk
      end

      it 'returns successful response' do
        request
        expect(response).to be_successful
      end

      it 'renders proper template' do
        request
        expect(response).to render_template(:index)
      end

      it 'shows all reservations in desc order' do
        request
        expect(assigns(:reservations)).to eq([reservation_at_desk, reservation])
      end
    end
  end

  describe 'GET /reservations/:id' do
    subject(:request) { get reservation_url(reservation) }

    context 'when not logged-in' do
      before { request }
      it 'returns status 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to sign in' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when logged-in as a regular user' do
      before do
        sign_in user
        request
      end
      it 'returns successful response' do
        expect(response.status).to eq(200)
      end

      it 'renders proper template' do
        expect(response).to render_template(:show)
      end
    end

    context 'when logged-in as a manager' do
      before do
        sign_in manager
        request
      end
      it 'returns successful response' do
        expect(response.status).to eq(200)
      end

      it 'renders proper template' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET /screenings/:id/reservations/new' do
    subject(:request) { get("/screenings/#{screening.id}/reservations/new") }

    context 'when not logged-in' do
      before { request }
      it 'returns status 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to sign in' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when logged-in as a regular user' do
      before do
        sign_in user
        request
      end

      it 'returns successful response' do
        expect(response.status).to eq(200)
      end

      it 'renders proper template' do
        expect(response).to render_template(:new)
      end
    end

    context 'when logged-in as a manager' do
      before do
        sign_in manager
        request
      end

      it 'returns successful response' do
        expect(response.status).to eq(200)
      end

      it 'renders proper template' do
        expect(response).to render_template(:new)
      end
    end
  end
  describe 'POST /screenings/:id/reservations' do
    subject(:request) { post("/screenings/#{screening.id}/reservations", params:) }
    let(:params) do
      {
        seats:
      }
    end
    let(:seats) { %w[1 10] }
    context 'when not logged-in' do
      before { request }
      it 'returns status 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to sign in' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when logged-in as a regular user' do
      before { sign_in user }
      context 'when params valid' do
        it 'returns successful response' do
          request
          expect(response.status).to eq(302)
        end

        it 'creates new reservation record' do
          expect { post("/screenings/#{screening.id}/reservations", params:) }.to change(Reservation, :count).by(1)
        end
      end

      context 'when params invalid' do
        let(:seats) { [] }
        it 'returns unprocessable entity status' do
          request
          expect(response.status).to eq(422)
        end

        it 'does not create new reservation record' do
          expect { post("/screenings/#{screening.id}/reservations", params:) }.not_to change(Reservation, :count)
        end
      end
    end
  end

  describe 'POST screenings/:id/reservations/offline' do
    subject(:request) { post("/screenings/#{screening.id}/reservations/offline", params:) }
    let(:params) do
      {
        seats:
      }
    end
    let(:seats) { %w[1 10] }
    context 'when not logged-in' do
      before { request }
      it 'returns status 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to sign in' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when logged-in as a regular user' do
      before do
        sign_in user
        request
      end
      it 'returns status 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to root' do
        expect(response).to redirect_to('/')
      end
    end

    context 'when logged-in as a manager' do
      before { sign_in manager }
      context 'when params valid' do
        it 'returns successful response' do
          request
          expect(response.status).to eq(302)
        end

        it 'creates new reservation record' do
          expect do
            post("/screenings/#{screening.id}/reservations/offline", params:).to change(Reservation, :count).by(1)
          end
        end
      end
      context 'when params invalid' do
        let(:seats) { [] }
        it 'returns unprocessable entity status' do
          request
          expect(response.status).to eq(422)
        end

        it 'does not create new reservation record' do
          expect { post("/screenings/#{screening.id}/reservations", params:) }.not_to change(Reservation, :count)
        end
      end
    end
  end

  describe 'PUT /reservations/:id' do
    subject(:request) { put("/reservations/#{reservation.id}", params:) }
    let(:params) do
      {
        id: reservation.id,
        status:
      }
    end
    let(:status) { :accepted }
    context 'when not logged-in' do
      before { request }
      it 'returns status 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to sign in' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when logged-in as a regular user' do
      before do
        sign_in user
        request
      end
      it 'returns status 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to root' do
        expect(response).to redirect_to('/')
      end
    end

    context 'when logged-in as a manager' do
      before { sign_in manager }

      context 'when status valid' do
        it 'returns status 302' do
          request
          expect(response.status).to eq(302)
        end

        it 'changes reservation status to accepted' do
          expect { request }.to change { reservation.reload.status }.from('booked').to('accepted')
        end
      end
    end
    context 'when status invalid' do
      let(:status) { nil }

      it 'returns status 302' do
        request
        expect(response.status).to eq(302)
      end

      it 'does not change reservation status to accepted' do
        expect { request }.not_to change { reservation.reload.status }
      end
    end
  end

  describe 'DELETE /reservations/:id' do
    subject(:request) { delete("/reservations/#{reservation.id}") }
    context 'when not logged-in' do
      before { request }
      it 'returns status 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to sign in' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when logged-in as a regular user' do
      before { sign_in user }

      it 'returns status 302' do
        request
        expect(response.status).to eq(302)
      end

      it 'changes reservation status to cancelled' do
        expect { request }.to change { reservation.reload.status }.from('booked').to('cancelled')
      end
    end

    context 'when logged-in as a manager' do
      before { sign_in manager }

      it 'returns status 302' do
        request
        expect(response.status).to eq(302)
      end

      it 'changes reservation status to cancelled' do
        expect { request }.to change { reservation.reload.status }.from('booked').to('cancelled')
      end
    end
  end
end
