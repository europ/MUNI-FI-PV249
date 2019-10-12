Rails.application.routes.draw do

  get 'session/new'
  get 'session/create'
  get 'session/destroy'
  resources :users
  resources :issues
  #resources :sessions
  resources :repositories

  root to: 'repositories#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
