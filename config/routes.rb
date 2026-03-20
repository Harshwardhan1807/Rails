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
end
