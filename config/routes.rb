Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  devise_scope :user do
    resources :users, only: %i[index show]
  end

  get 'posts/index'

  resources :friend_requests, only: %i[create destroy]
  resources :friendships, only: %i[create destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
