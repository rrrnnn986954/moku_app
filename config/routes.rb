Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  resources :sessions, only: [:create]
  
end
