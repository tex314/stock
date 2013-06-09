Stock::Application.routes.draw do

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resource :sessions, only: [:new, :create]
  resources :users

  get 'tags/:tag', to: "items#index", as: :tag
  root to: 'items#index'
  resources :tags, only: [:index]
  resources :items, except: [:show]
end
