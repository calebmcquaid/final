Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root to: 'users#index'

  # get '/auth/:provider/callback', to: 'users#index'
  get '/auth/fitbit/callback', to: 'fitbit#callback'
  get '/auth/strava/callback', to: 'strava#callback'

  # get '/auth/fitbit', to: 'fitbit#make_request'

  get 'https://www.strava.com/oauth/authorize', to: 'strava#make_request' 

  resources :competitions

  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
