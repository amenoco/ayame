Rails.application.routes.draw do

# 顧客用
# URL /users/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
}
    
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

    ###topの設定
root to: 'public/homes#top'

 #publicの設定
scope module: :public do
    get '/about' => 'homes#about'
    get 'search' => 'homes#search', as: 'search'
    get '/privacy_policy' => 'homes#privacy_policy', as: 'privacy_policy'
    get '/terms' => 'homes#terms', as: 'terms'
    get '/guideline' => 'homes#guideline', as: 'guideline'
    
    post '/guest', to: 'guest_sessions#create'
    get '/users/my' => 'users#my', as: 'my_page'
    get '/users/infomation/edit' => 'users#edit', as: 'users_edit'
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdraw' => 'users#withdraw', as: 'withdraw'


    resources :users, :posts, :details, :address, :my do
      collection do
        get :notifications
      end
    end
    resources :users, only: [:show,:index,:edit,:update] do
      member do
        get :favorites
      end
    end
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    end
end
       

  #adminの設定
  namespace :admin do
  
  root to: '/admin/homes#top'
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resources :post_comments, only: [:create, :destroy] 
    end
    resources :users, :categories, :posts, :details
    get '/users/:id/posts', to: 'user/posts#index', as: 'user_posts' 
    
  end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
