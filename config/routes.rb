Rails.application.routes.draw do
  root 'movies#index'
  resources :movies, only: %i[show index] do
    resources :screenings, only: [:show]
  end

  resources :screenings, only: [:show] do
    resources :reservations, only: %i[new create show update]
  end
end
