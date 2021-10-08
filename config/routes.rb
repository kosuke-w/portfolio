Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_login'
  end
  root to: 'homes#top'

  resources :records, only: [:create, :destroy]
  resources :users do
    member do
      get :my_page
      get :unsubscribe
    end
  end
  resources :items
  resources :coordinates
  resources :posts, except: [:edit, :update] do
    resources :post_comments, only: [:create, :destroy]
  end
end
