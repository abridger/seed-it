Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root      'meadows#index'
  resources :meadows
  resources :users
  resources :account_activations, only: [:edit]
  get       'sessions/new'
  get       '/home',              to: 'static_pages#home'
  get       '/help',              to: 'static_pages#help'
  get       '/signup',            to: 'users#new'
  get       '/login',             to: 'sessions#new'
  post      '/login',             to: 'sessions#create'
  delete    '/logout',            to: 'sessions#destroy'
end
