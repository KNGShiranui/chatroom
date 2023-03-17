Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, only: %i[new create edit update show destroy]
  resources :conversations do
    resources :messages
  end
  resources :sessions, only: %i[new create destroy]

end
