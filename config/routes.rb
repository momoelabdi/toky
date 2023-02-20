Rails.application.routes.draw do
  root 'homepage#index'
  get 'clients/index'
  get 'clients/create'
  get 'clients/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
