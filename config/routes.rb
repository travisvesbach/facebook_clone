Rails.application.routes.draw do

  get 'static_pages/home'

  devise_for :users

  resources :users, only: [:show, :index, :destroy] do
  	member do
	  resources :friendships, only: [:create, :update, :destroy]
	end
  end

  resources :notifications, only: [:index, :show]
  resources :posts, only:  [:create, :destroy] do
  	member do
	  resources :likes, only: [:create, :destroy]
	end
end


#  resources :users, only: [:show, :index]
#  resources :friendships, only: [:create, :update, :destroy]

  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
