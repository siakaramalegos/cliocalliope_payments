Rails.application.routes.draw do
  get 'pages/index'
  get '/users' => 'pages#users'
  get 'pages/link_notify'

  resources :payments
  resources :customers
  resources :invoices
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  root 'pages#index'
end
