Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users do
   resources :projects , only: [:index, :show, :create, :update, :destroy]
   resources :tasks
  end

  resources :projects do
   resources :tasks
  end
  resources :tasks

  resources :notifications, only: [:create]
  mount ActionCable.server => '/cable'
  post 'tasks', to: 'tasks#create'

  #JWT

  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'

  # resources :users do
  #   get 'projects', to: 'users#show'
  # end
  # Defines the root path route ("/")
  # root "posts#index"
end
