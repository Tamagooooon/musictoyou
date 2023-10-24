Rails.application.routes.draw do
  namespace :admin do
    get 'post/index'
    get 'post/show'
    get 'post/edit'
  end
  namespace :admin do
    get 'tags/index'
    get 'tags/edit'
  end
  # ゲストログイン


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
    end
  end

  scope module: :user do
    resources :users, only: [:show, :edit, :update]
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
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
  end
  
  resources :posts
    namespace :admin do
      resources :posts, only: [:index, :show, :edit, :update, :destroy]
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
