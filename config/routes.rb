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
  get 'users/my_page', to: 'users#show'
  get 'users/my_page/edit', to: 'users#edit'
  patch 'users/my_page', to: 'users#update'
  get 'users/unsubscribe'
  patch 'users/withdraw'
  resources :posts, only: [:new, :index, :show, :create, :edit, :update,:destroy]
end

namespace :admin do
 root :to => "homes#top"
 resources :genres, only: [:index, :create, :edit, :update]
 resources :users, only: [:index, :show, :edit, :update]
end


# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
