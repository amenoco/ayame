Rails.application.routes.draw do

  namespace :public do
    get 'details/new'
    get 'details/index'
    get 'details/show'
    get 'details/edit'
    get 'details/create'
    get 'details/update'
    get 'details/destroy'
  end
  namespace :admin do
    get 'details/new'
    get 'details/index'
    get 'details/show'
    get 'details/edit'
    get 'details/create'
    get 'details/update'
    get 'details/destroy'
  end
  namespace :admin do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/create'
    get 'posts/update'
    get 'posts/destroy'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/create'
    get 'posts/update'
    get 'posts/destroy'
  end
  namespace :public do
    get 'users/new'
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/create'
    get 'users/update'
    get 'users/destroy'
  end
  namespace :admin do
    get 'users/new'
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/create'
    get 'users/update'
    get 'users/destroy'
  end
  namespace :admin do
    get 'categories/new'
    get 'categories/index'
    get 'categories/show'
    get 'categories/edit'
    get 'categories/create'
    get 'categories/update'
    get 'categories/destroy'
  end
  get 'category/new'
  get 'category/index'
  get 'category/show'
  get 'category/edit'
  get 'category/create'
  get 'category/update'
  get 'category/destroy'
  get 'user/new'
  get 'user/index'
  get 'user/show'
  get 'user/edit'
  get 'user/create'
  get 'user/update'
  get 'user/destroy'
  devise_for :users
  root to: 'homes#top'
  
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  get 'homes/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
