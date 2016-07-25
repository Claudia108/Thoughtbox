Rails.application.routes.draw do
  root 'sessions#new'
  resources :links
  resources :users

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :links
    end
  end

  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
