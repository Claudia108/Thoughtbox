Rails.application.routes.draw do
  root 'links#index'
  resources :links, only: [:index, :create, :edit, :update]
  resources :users, only: [:new, :create]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
