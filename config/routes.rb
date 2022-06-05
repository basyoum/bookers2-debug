Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'homes#top'
  root to: "homes#top"
  get "home/about"=>"homes#about", as: 'about'


  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do

    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "search", to: "users#search"
  end

  get "search" => "searches#search"

  #1対1のチャット機能
  #get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only:[:show, :create]
  #グループ機能の作成
  resources :groups, only: [:index, :show, :create, :update, :new, :edit] do
    resource :group_users, only: [:create, :destroy]
    resources :event_notices, only: [:new, :create]
    get "event_notices" => "event_notices#sent"
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 end
