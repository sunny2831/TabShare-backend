Rails.application.routes.draw do

  get 'payments/create'
  resources :users, only: [:create, :index]
  resources :tabs, only: [:create, :show]
  resources :payments, only: [:create]
  resources :friendships, only: [:create, :show]
  get 'users/search', :to => 'users#search'
  get 'users/recent_activity', :to => 'users#recent_activity'

end
