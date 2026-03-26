Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :channels do
    member do
      post :toggle_subscription, to: "subscriptions#toggle"
    end
    resources :videos, only: [:new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
  end
  root "users#home"
  resources :notifications, only: [:index, :destroy] do
    member do
      patch :mark_as_read
    end
    collection do
      patch :mark_all_as_read
      patch :mark_all_as_unread
    end
  end
  match "*path", to: "application#not_found", via: :all, constraints: ->(req) { !req.path.start_with?("/rails/active_storage") }
end
