Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get 'sections', to: 'sections#index'
  get 'actions/new'

  resources :sections, only: [:create, :index]
  resources :actions, only: [:new]

end
