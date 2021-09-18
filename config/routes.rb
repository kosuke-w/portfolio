Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'


  resources :records, only: [:create, :destroy]
  resources :users do
    member do
      get :my_page
      get :unsubscribe
      patch :withdraw
    end
  end
  resources :items
  resources :coordinates
  resources :posts, except: [:edit, :update] do
    resources :post_comments, only: [:create, :destroy]
  end


end
