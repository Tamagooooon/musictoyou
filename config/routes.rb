Rails.application.routes.draw do
  # ゲストログイン


  # 顧客用
  # URL /users/sign_in ...
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  scope module: :user do
    resources :posts, only: [:new, :index, :show, :create, :destroy]
      resources :user, only: [:show, :edit]
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  end

  root to: "user/homes#top"
  get 'about' => 'user/homes#about'


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
