Rails.application.routes.draw do
  devise_for :users #これを一番最初に書かないと、deviseじゃない方のusers#アクションが呼ばれてしまう。
  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :following, :followers
    end
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  root "homes#top"
  get "home/about" => "homes#about"
  get "/search" => "searches#search"
end
