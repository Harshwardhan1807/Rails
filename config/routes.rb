Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :channels do
    member do
      post :toggle_subscription, to: "subscriptions#toggle"
    end
    resources :videos, only: [:new, :create, :edit, :update, :destroy]
  end
  root "users#home"
  resources :notifications, only: [:index, :destroy] do
    member do
      patch :mark_as_read
    end
  end
  get "movies/top", to: "movies#top", as: "top_movies"
  resources :movies, only: [:index, :show, :destroy]
end
