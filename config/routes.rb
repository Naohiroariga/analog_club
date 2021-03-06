Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :games do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :chats, only: [:show, :create]
    get "search" => "searches#search", as: "search"
    get "filter" => "searches#filter", as: "filter"
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :games, only: [:index, :show, :update] do
      resources :comments, only: [:update]
    end
    get "search" => "searches#search", as: "search"
    get "filter" => "searches#filter", as: "filter"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
