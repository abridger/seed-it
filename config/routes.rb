Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root      'meadows#index'
  resources :meadows
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  get       'sessions/new'
  get       '/home',              to: 'static_pages#home'
  get       '/help',              to: 'static_pages#help'
  get       '/signup',            to: 'users#new'
  get       '/login',             to: 'sessions#new'
  post      '/login',             to: 'sessions#create'
  delete    '/logout',            to: 'sessions#destroy'
end
