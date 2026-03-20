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
  match "*path", to: "application#not_found", via: :all
end
