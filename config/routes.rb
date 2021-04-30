Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  get '/search' => 'pages#search', :as => 'search_page'
  get '/my_reviews' => 'users#my_reviews', :as => 'my_reviews'
  # match '/my_reviews', to: 'users#my_reviews', via: 'get'

  get 'services' => 'pages#services', constraints: { format: 'html' }
  get 'about' => 'pages#about', constraints: { format: 'html' }
  get 'jobs' => 'pages#jobs', constraints: { format: 'html' }
  get 'terms' => 'pages#terms', constraints: { format: 'html' }
  get 'privacy_policy' => 'pages#privacy_policy', constraints: { format: 'html' }

  root to: 'pages#home'
  # resources :products_controller do
  #   collection do
  #     get :set_product_sort
  #   end
  # end
  resources :users
  resources :products do
    resources :reviews
  end
  resources :reviews
  
end
