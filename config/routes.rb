Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get 'users/my_page' => 'users#show'
  get 'users/unsubscribe' => 'users#unsubscribe'
  patch 'users/withdraw' => 'users#withdraw'


  resources :users
  resources :items
  resources :coordinates
  resources :posts, except: [:edit, :update] do
    resources :post_comments, only: [:creste, :destroy]
  end


end
