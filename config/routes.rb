Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items 
  resources :orders, only: [:index, :new, :create] do
    resources :addresses, only: [:new, :create]
  end
end
