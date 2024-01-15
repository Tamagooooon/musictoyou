Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  # 顧客用
  # URL /users/sign_in ...
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  scope module: :user do
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
      resources :bookmarks, only: [:create, :destroy]
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    end
  end

  scope module: :user do
    resources :users, only: [:index, :show, :edit, :update]
    get "search" => "posts#search"
  end

  root to: "user/homes#top"
  get 'about' => 'user/homes#about'


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
      resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  namespace :admin do

  end

  namespace :admin do

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
