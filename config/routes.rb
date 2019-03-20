Rails.application.routes.draw do

  # get 'payments/create'
  # resources :users, only: [:create, :index]
  # resources :tabs, only: [:create, :show]
  # resources :payments, only: [:create]
  # resources :friendships, only: [:create, :show]
  # get 'users/search', :to => 'users#search'
  # get 'users/recent_activity', :to => 'users#recent_activity'

  resources :users, only: [:create, :index]

  post 'login', to: 'users#login'
  get 'validate', to: 'users#validate'
  get 'owed_by_tabs', to: 'users#get_owed_by_tabs'
  get 'owed_to_tabs', to: 'users#get_owed_to_tabs'


end
