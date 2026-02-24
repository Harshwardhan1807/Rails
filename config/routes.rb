Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :channels
  post "channels/:id/subscribe", to: "subscriptions#create", as: :channel_subscription
  delete "channels/:id/unsubscribe", to: "subscriptions#destroy", as: :channel_unsubscription

  root "users#home"
  get "*path", to: "users#home", via: :all
end
