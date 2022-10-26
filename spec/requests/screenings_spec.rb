require 'rails_helper'

RSpec.describe '/screenings', type: :request do
  let(:manager) { create(:user, role: 'manager') }
  let(:user) { create(:user) }
  describe 'GET /screenings' do
    subject(:request) { get screenings_url }

    it 'returns successful response' do
      request
      expect(response).to be_successful
    end

    it 'renders proper template' do
      request
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /movies/:id/screenings/:id' do
    subject(:request) { get("/movies/#{movie.id}/screenings/#{screening.id}") }
    let(:movie) { create(:movie) }
    let(:screening) { create(:screening, movie:) }

    it 'returns successful response' do
      request
      expect(response).to be_successful
    end

    it 'renders proper template' do
      request
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /screenings/new' do
    subject(:request) { get new_screening_url }

    context 'when not logged-in' do
      let(:user) { nil }
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
        expect(response.status).to eq(302)
      end

      it 'redirects to root' do
        expect(response).to redirect_to('/')
      end
    end
    context 'when logged-in as a manager' do
      before do
        sign_in manager
        request
      end
      it 'returns successful response' do
        expect(response).to be_successful
      end
      it 'renders proper template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST /screenings' do
    subject(:request) { post('/screenings', params:) }
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:start_time) { Time.current + 2.hours }
    let(:params) do
      {
        screening: {
          movie_id: movie.id,
          hall_id: hall.id,
          start_time:
        }
      }
    end
    context 'when not logged-in' do
      let(:user) { nil }
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
      context 'when params valid' do
        before { sign_in manager }

        it 'returns successful response' do
          request
          expect(response.status).to eq(302)
        end
        it 'creates new screening record' do
          expect { post('/screenings', params:) }.to change(Screening, :count).by(1)
        end
      end
    end
    context 'when params invalid' do
      let(:start_time) { nil }
      before do
        sign_in manager
        request
      end
      it 'returns expected response' do
        expect(response.status).to eq(422)
      end

      it 'does not create new screening record' do
        expect { post('/screenings', params:) }.not_to change(Screening, :count)
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET /screenings/:id/edit' do
    let(:screening) { create(:screening) }
    subject(:request) { get edit_screening_url(screening) }

    context 'when not logged-in' do
      let(:user) { nil }
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
        expect(response.status).to eq(302)
      end

      it 'redirects to root' do
        expect(response).to redirect_to('/')
      end
    end
    context 'when logged-in as a manager' do
      before do
        sign_in manager
        request
      end
      it 'returns successful response' do
        expect(response).to be_successful
      end
      it 'renders proper template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PUT /screenings/:id' do
    subject(:request) { post('/screenings', params:) }
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:screening) { create(:screening, movie:, hall:, start_time: Time.current + 5.hours) }
    let(:params) do
      {
        screening: {
          movie_id: movie.id,
          hall_id: hall.id,
          start_time:
        }
      }
    end
    let(:start_time) { Time.current + 2.hours }
    subject(:request) { put("/screenings/#{screening.id}", params:) }
    context 'when not logged-in' do
      let(:user) { nil }
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
      context 'when params valid' do
        before { sign_in manager }

        it 'returns successful response' do
          request
          expect(response.status).to eq(302)
        end
      end
    end
    context 'when params invalid' do
      let(:start_time) { nil }
      before do
        sign_in manager
        request
      end
      it 'returns expected response' do
        expect(response.status).to eq(422)
      end

      it 'does not update screening record' do
        expect { put("/screenings/#{screening.id}", params:) }.not_to change { screening.reload.start_time }
      end

      it 'renders new template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /screenings/:id' do
    let(:screening) { create(:screening) }
    subject(:request) { delete("/screenings/#{screening.id}") }
    context 'when not logged-in' do
      let(:user) { nil }
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
      before do
        sign_in manager
        screening
      end
      it 'returns status 302' do
        request
        expect(response.status).to eq(302)
      end

      it 'deletes a screening' do
        expect { delete("/screenings/#{screening.id}") }.to change(Screening, :count).by(-1)
      end
    end
  end
end
