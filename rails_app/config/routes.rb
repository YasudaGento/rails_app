Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :application

  # スポ勉
  resources :demo_lists, only: [:index]
  namespace :demo_lists do
    get :get
  end
end