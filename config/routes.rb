Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :channels do
    resources :videos, only: [:new, :create]
  end
  post "channels/:id/subscribe", to: "subscriptions#create", as: :channel_subscription
  delete "channels/:id/unsubscribe", to: "subscriptions#destroy", as: :channel_unsubscription

  root "users#home"
end
