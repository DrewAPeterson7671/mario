Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  root to: 'pages#home'
  resources :users
  resources :products do
    resources :reviews
  end
  resources :reviews
end
