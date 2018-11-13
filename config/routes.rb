Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root to: 'users#current_user_home'

  resources :competitions do
    member do
      get "fetch_stats"
    end
  end

  get '/about', to: 'about#index'

  # get '/auth/:provider/callback', to: 'users#index'
  get '/auth/fitbit/callback', to: 'fitbit#callback'
  get '/auth/strava/callback', to: 'strava#callback'

  # get '/auth/fitbit', to: 'fitbit#make_request'

  get 'https://www.strava.com/oauth/authorize', to: 'strava#make_request' 

  get ':competitions/create', to: 'competitions#create'

  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
