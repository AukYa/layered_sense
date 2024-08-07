Rails.application.routes.draw do
  get 'questions/index'
  get 'questions/show'
  get 'questions/edit'
  get 'questions/new'
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :works, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :tags, only: [:index, :destroy]
  end
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :works do
    resources :comments, only: [:create, :destroy]
  end
  resources :tags,　only: [:show]
  resources :groups do
    resource :memberships, only: [:create, :destroy]
    resources :chats, only: [:create, :destroy]
  end
  resources :questions do
    resources :answers, only: [:edit, :update, :create, :destroy]
    patch 'best'
  end
  get 'search' => 'searches#search'
  get 'homes/top'
  get 'homes/about', to: 'homes#about', as: :about
  root to: "homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
