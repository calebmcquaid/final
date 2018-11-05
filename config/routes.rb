Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root to: "competitions#new"


  resources :competitions

  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
