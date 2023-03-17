Rails.application.routes.draw do
  root 'sessions#new'
  resources :conversations do
    resources :messages
  end
  resources :sessions, only: [:new, :create, :destroy]
end
