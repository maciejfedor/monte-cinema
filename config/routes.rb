Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :movies, only: %i[show index] do
    resources :screenings, only: [:show]
  end

  resources :screenings, only: [:show] do
    resources :reservations, only: %i[new create show update destroy]
  end

  resources :reservations, only: %i[index]
end
