Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  resources :sections, only: [:create, :index]
  get 'sections', to: 'sections#index'

end
