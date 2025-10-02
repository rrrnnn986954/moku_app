Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  resources :sections, only: [:create]
  get 'sections', to: 'sections#create'

end
