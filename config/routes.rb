Rails.application.routes.draw do

  get 'static_pages/home'

  devise_for :users

  resources :users, only: [:show, :index, :destroy] do
	  resources :friendships, only: [:create, :update, :destroy]
  end

  resources :notifications, only: [:index, :show]

  resources :posts, only:  [:create, :destroy] do
	  resources :likes, only: [:create, :destroy]
	  resources :comments, only: [:create, :destroy]
  end


  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
