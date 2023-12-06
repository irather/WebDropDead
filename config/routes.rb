# config/routes.rb

Rails.application.routes.draw do
  root 'sessions#new'

  # Sessions routes for login and logout
  get '/login', to: 'sessions#new', as: 'sign_in'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Users routes for signup, user details, and gameplay
  resources :users, only: [:new, :create, :show]
  get '/play_game', to: 'users#play_game', as: 'play_game'
  get '/game_history', to: 'users#game_history', as: 'game_history'
  get '/exit_game', to: 'users#exit_game', as: 'exit_game'

  # Additional Sessions routes
  resources :sessions, only: [:new, :create]

  get '/display_game', to: 'users#display_game', as: 'display_game'

  # Uncomment the line below if you wish to view 'Hello, World!'
  # root 'pages#index'
end
