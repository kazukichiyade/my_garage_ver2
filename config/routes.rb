Rails.application.routes.draw do
  root 'home_pages#home'
  get '/signup', to: 'users#new'
  post '/sigup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users
end
