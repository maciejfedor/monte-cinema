require 'rails_helper'

RSpec.describe '/movies', type: :request do
  let(:manager) { create(:user, role: 'manager') }
  let(:user) { create(:user) }
  describe 'GET /movies' do
    subject(:request) { get movies_url }
    let(:movies) { create_list(:movie, 5) }

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
      before { sign_in user }

      it 'returns status 302' do
        request
        expect(response.status).to eq(302)
      end

      it 'redirects to root' do
        request
        expect(response).to redirect_to('/')
      end
    end

    context 'when logged-in as a manager' do
      before do
        sign_in manager
        movies
      end

      it 'returns successful response' do
        request
        expect(response).to be_successful
      end

      it 'renders proper template' do
        request
        expect(response).to render_template(:index)
      end

      it 'displays all movies' do
        request
        expect(assigns(:movies)).to eq(movies)
      end
    end
  end

  describe 'GET /movies/:id' do
    subject(:request) { get movie_url(movie) }
    let(:movie) { create(:movie) }

    before { request }
    it 'returns successful response' do
      expect(response).to be_successful
    end

    it 'renders proper template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /movies/new' do
    subject(:request) { get new_movie_url }

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

  describe 'POST /movies' do
    let(:params) do
      {
        movie: {
          title:,
          duration: 120
        }
      }
    end
    let(:title) { 'title' }
    subject(:request) { post('/movies', params:) }
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
        before do
          sign_in manager
          request
        end
        it 'returns successful response' do
          expect(response.status).to eq(302)
        end
        it 'creates new movie record' do
          expect { post('/movies', params:) }.to change(Movie, :count).by(1)
        end
      end
    end
    context 'when params invalid' do
      let(:title) { nil }
      before do
        sign_in manager
        request
      end
      it 'returns expected response' do
        expect(response.status).to eq(422)
      end

      it 'does not create new movie record' do
        expect { post('/movies', params:) }.not_to change(Movie, :count)
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET /movies/:id/edit' do
    let(:movie) { create(:movie) }
    subject(:request) { get edit_movie_url(movie) }

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

  describe 'PUT /movies/:id' do
    let(:movie) { create(:movie, title: 'title', duration: 100) }
    let(:params) do
      {
        movie: {
          title:,
          duration: 120
        }
      }
    end
    let(:title) { 'title updated' }
    subject(:request) { put("/movies/#{movie.id}", params:) }
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
        it 'updates movie record' do
          expect { put("/movies/#{movie.id}", params:) }.to change {
          movie.reload.title
          }.from('title').to('title updated').and change {
          movie.reload.duration
          }.from(100).to(120)
        end
      end
    end
    context 'when params invalid' do
      let(:title) { nil }
      before do
        sign_in manager
        request
      end
      it 'returns expected response' do
        expect(response.status).to eq(422)
      end

      it 'does not update movie record' do
        expect { put("/movies/#{movie.id}", params:) }.not_to change(Movie, :count)
      end

      it 'renders new template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /movies/:id' do
    let(:movie) { create(:movie) }
    subject(:request) { delete("/movies/#{movie.id}") }
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
        movie
      end
      it 'returns status 302' do
        request
        expect(response.status).to eq(302)
      end

      it 'deletes a movie' do
        expect { delete("/movies/#{movie.id}") }.to change(Movie, :count).by(-1)
      end
    end
  end
end
