Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :movies, only: %i[show index] do
    resources :screenings, only: [:show]
  end

  resources :screenings, only: [:show] do
    resources :reservations, only: %i[new create]
  end
  resources :reservations, only: %i[index show update destroy]

  
end
