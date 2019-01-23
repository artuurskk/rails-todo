Rails.application.routes.draw do
  root to: 'pages#index'


  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  controller :tasks do
      put '/tasks', to: 'tasks#check'
  end
  resources :tasks

  get 'signup',  to: 'users#new', as: 'signup'
  get 'login',   to: 'sessions#new', as: 'login'
  get 'logout',  to: 'sessions#destroy', as: 'logout'

end
