Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "welcome#index"

  resources :merchants

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  resources :reviews, only: [:edit, :update, :destroy]


  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  patch "/cart", to: "cart#increment_decrement"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  resources :orders, only: [:new, :create, :show]

  get '/register', to: "users#new"
  post '/register', to: "users#create"
  get '/profile/edit', to: 'users#edit'
  patch '/profile', to: 'users#update'
  get '/profile/password', to: "users#edit_password"
  patch '/profile/password', to: "users#update_password"


  get '/profile', to: 'users#show'
  get '/profile/orders', to: 'user_orders#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  get '/profile/orders/:id', to: 'user_orders#show'
  patch '/profile/orders/:id', to: 'orders#cancel'


  namespace :merchant do
    get '/', to: "dashboard#show"
    patch "/items/:id/:disable_enable", to: 'items#update'
    delete "/items/:id/destroy", to: 'items#destroy'

    resources :items, only: [:index, :update, :new, :create]
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :merchants, only: [:index, :show]
    get '/merchant/:id', to: 'merchants#show'
    patch '/merchants/:id/:disable_enable', to: 'merchants#update'
  end
end
