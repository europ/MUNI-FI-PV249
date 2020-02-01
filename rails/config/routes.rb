Rails.application.routes.draw do

  resources :users
  resources :issues
  resources :repositories

  root to: 'users#index'

  get 'login', to: 'session#new'
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
