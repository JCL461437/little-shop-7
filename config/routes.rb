Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'

  # get "/merchants/:id/dashboard", to: "merchant#show"
resources :merchants, only: [:show] do
  resources :dashboard, only: [:index]
  end
end
