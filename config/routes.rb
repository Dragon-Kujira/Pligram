Rails.application.routes.draw do
  
# 顧客用
# URL /users/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
  root :to => "homes#top"
  get '/search', to: 'searches#search'
  get '/my_page', to: 'users#show', as: 'my_page'
  get 'my_page/edit', to: 'users#edit', as: 'edit_my_page'
  patch 'my_page/edit', to: 'users#update'
  get 'users/unsubscribe'
  patch 'users/withdraw'
  get 'users/:user_id/userposts', to: 'users#userposts', as: 'userposts'
  resources :users, only: [:show]
  resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
  resource :favorite, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]  
  end
end

namespace :admin do
 root :to => "homes#top"
 resources :genres, only: [:index, :create, :edit, :update]
 resources :users, only: [:index, :show, :edit, :update]
 resources :posts, only: [:index, :show, :edit, :update, :destroy] do
 resources :comments, only: [:create, :destroy]  
end
end

end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
