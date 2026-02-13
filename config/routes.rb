Rails.application.routes.draw do
  resources :users
  resources :channels

  root "users#home"
end
