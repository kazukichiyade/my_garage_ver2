Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'home_pages#home'

  get '/signup', to: 'users#signup' #new
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#login' #new
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :account_activation, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
