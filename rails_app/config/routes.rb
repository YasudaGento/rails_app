Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :application

  resources :demo_lists, only: [:index]
  namespace :demo_lists do
    get :get
  end

  resources :users, only: [:index]
  namespace :users do
    get :get
  end

  resources :articles, only: [:index]
  namespace :articles do
    get :get
  end

  # スラック通知
  namespace :slacks do
    post :notificate
  end
end