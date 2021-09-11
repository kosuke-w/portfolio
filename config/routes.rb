Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  resources :items
  resources :coordinates
  resources :posts, except: [:edit, :update] do
    resources :post_comments, only: [:creste, :destroy]
  end


end
