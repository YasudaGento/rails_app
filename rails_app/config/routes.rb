Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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
    post :update
  end

  resources :article_details, only: [:index]
  namespace :article_details do
    get :get
  end

  # スラック通知
  namespace :slacks do
    post :notificate
  end

  resources :sessions, only: [:index]
  namespace :sessions do
    post :signin
    delete :signout    
  end
end