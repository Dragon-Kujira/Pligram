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
  get '/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
  patch 'users/withdraw', to: 'users#withdraw'
  get 'user_posts/:user_id', to: 'users#user_posts', as: 'user_posts'
  get 'user_favorites/:user_id' => 'users#user_favorites', as: 'user_favorites'
  resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
    get 'new', to: 'posts#new'
    post '/', to: 'posts#create' 
  resource :favorite, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :destroy] 
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index]
  resources :tags, only: [:index]
  get '/tags/:tag_id/posts', to: 'tags#show', as: 'tag_posts'
  resources :genres, only: [:index]
  get 'genres/:genre_id/posts', to: 'genres#show', as: 'genre_posts'
end

namespace :admin do
  root :to => "homes#top"
  resources :genres, only: [:index, :create, :edit, :update]
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :posts, only: [:index, :show, :edit, :update, :destroy] do
   resources :comments, only: [:create, :destroy] 
  end
 end

end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
