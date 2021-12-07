Rails.application.routes.draw do
  devise_for :users #これを一番最初に書かないと、deviseじゃない方のusers#アクションが呼ばれてしまう。
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
  end
  root "homes#top"
  get "home/about" => "homes#about"
end
