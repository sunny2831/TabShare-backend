Rails.application.routes.draw do

  # get 'payments/create'
  # resources :users, only: [:create, :index]
  # resources :tabs, only: [:create, :show]
  # resources :payments, only: [:create]
  # resources :friendships, only: [:create, :show]
  # get 'users/search', :to => 'users#search'
  # get 'users/recent_activity', :to => 'users#recent_activity'

  resources :users, only: [:create, :index] do
    get 'friends', to: 'users#get_friends'
  end

  get 'owed_by_tabs', to: 'users#get_owed_by_tabs'
  get 'owed_to_tabs', to: 'users#get_owed_to_tabs'


  resources :tabs, only: [:create, :index, :destroy] do
    get 'payments', to: 'tabs#made_payments'
    post 'payments', to: 'tabs#make_payments'
  end


  post 'login', to: 'users#login'
  get 'validate', to: 'users#validate'


end
