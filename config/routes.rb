Rails.application.routes.draw do
  resources :users
  root to: 'products#index'
  resources :products do
    resources :reviews
  end
end
