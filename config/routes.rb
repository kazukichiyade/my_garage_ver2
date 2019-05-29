Rails.application.routes.draw do

  root 'home_pages#home'
  get 'signup', to: 'users#new'
end
