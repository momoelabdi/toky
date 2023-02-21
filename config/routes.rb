Rails.application.routes.draw do
  devise_for :users
  resources :clients, only: [:index, :create, :show, :update]
  # root 'home#index'
  root 'clients#index'
  get 'clients', to: 'clients#index'
  get 'clients/:id', to: 'clients#show'
  get 'clients/create'
  get 'clients/update'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
