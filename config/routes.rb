Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  devise_scope :user do
    get 'profile', action: :show, controller: 'users'
    resources :users, only: %i[index show]
  end

  resources :posts, only: %i[new create index]

  resources :likes, only: %i[create destroy]

  resources :friend_requests, only: %i[create destroy]
  resources :friendships, only: %i[create destroy]

  resources :notifications, only: %i[index destroy]

  resources :comments, only: %i[create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
