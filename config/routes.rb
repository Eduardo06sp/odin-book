Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  devise_scope :user do
    get '/users/', to: 'users#index'
    get '/users/:id', to: 'users#show'
  end

  get 'posts/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
