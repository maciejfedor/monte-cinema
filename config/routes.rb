Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :movies do
    resources :screenings, only: [:show]
  end

  resources :screenings, only: %i[show index] do
    resources :reservations, only: %i[new create]
  end
  resources :reservations, only: %i[index show update destroy]

  get '/user', to: 'users#show'

  post 'screenings/:screening_id/reservations/offline', to: 'reservations#create_at_desk', as: 'offline_reservation'
end
