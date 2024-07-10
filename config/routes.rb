Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :works
  get 'homes/top'
  get 'homes/about', to: 'homes#about', as: :about
  root to: "homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
