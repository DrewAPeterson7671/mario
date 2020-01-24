Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  
  resources :users
  root to: 'products#index'
  resources :products do
    resources :reviews
  end
end
