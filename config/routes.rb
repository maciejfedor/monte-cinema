Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users
  root 'pages#home'
  resources :movies do
    resources :screenings, only: [:show]
  end

  resources :screenings do
    resources :reservations, only: %i[new create]
  end
  resources :reservations, only: %i[index show update destroy]

  get '/user', to: 'users#show'

  post 'screenings/:screening_id/reservations/offline', to: 'reservations#create_at_desk', as: 'offline_reservation'

  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[index show] do
        resources :screenings, only: %i[show]
      end
      resources :screenings, only: %i[index show] do
        resources :reservations, only: %i[create]

        post '/reservations', to: 'reservations#create'
      end
      resources :reservations, only: %i[index show update destroy]
    end
  end
end
