Rails.application.routes.draw do
  root 'clients#index'
  devise_for :users
  resources :clients, only: [:index, :create, :show, :update , :destroy]

end
