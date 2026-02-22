Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :channels

  root "users#home"
end
