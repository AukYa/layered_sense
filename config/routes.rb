Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update] do
      patch 'withdraw'
    end
    resources :works, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :tags, only: [:index, :destroy]
    resources :groups, only: [:index, :show, :edit, :update, :destroy] do
      resources :chats, only: [:destroy]
    end
    resources :questions, only: [:index, :show, :edit, :update, :destroy] do
      resources :answers, only: [:destroy]
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :users, only: [:index, :show, :edit, :update] do
    patch 'withdraw'
  end
  resources :works do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    get 'favorites' => 'favorites#index'
  end
  resources :tags,　only: [:show]
  resources :groups do
    resource :memberships, only: [:create, :destroy]
    resources :chats, only: [:create, :destroy]
  end
  resources :questions do
    get 'my_questions' => 'questions#my_questions'
    resources :answers, only: [:create, :destroy] do
      patch 'best'
    end
  end
  resources :notifications, only: [:update]
  get 'search' => 'searches#search'
  get 'homes/top'
  get 'homes/about', to: 'homes#about', as: :about
  root to: "homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
