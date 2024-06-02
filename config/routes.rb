Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'
  
  resources :admin, only: [:index]      
  namespace :admin do 
    resources :merchants, only: [:index]
    resources :invoices, only: [:index]
  end
  
  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index]
  end
end

