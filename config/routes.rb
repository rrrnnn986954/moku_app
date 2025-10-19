Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  # セクションとアクションのルーティング
  resources :sections, only: [:index, :create] do
    member do
      get :chart
      patch :end_section
    end
    
    resources :actions, only: [:new, :create, :update, :edit] do
      patch :update_category, on: :member
    end
  end
  get 'feedbacks', to: 'feedbacks#index'
end

