Rails.application.routes.draw do
  root 'sessions#new'
  resources :links
  resources :users

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
