Stock::Application.routes.draw do
  get 'tags/:tag', to: "items#index", as: :tag
  root :to => 'items#index'
  resources :items
end
