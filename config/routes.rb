Rails.application.routes.draw do
  root 'links#index'
  resources :links
  resources :users

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :links
    end
  end
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
