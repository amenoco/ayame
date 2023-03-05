Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
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

    post '/guest', to: 'guest_sessions#create'
    get '/users/my' => 'users#my', as: 'my_page'
    get '/users/infomation/edit' => 'users#edit', as: 'users_edit'
    patch '/users/infomation' => 'users#update', as: 'uinfomation'
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdraw' => 'users#withdraw', as: 'withdraw'


    resources :users, :posts, :details, :address, :my
    
  end
resources :posts, only: [:new, :create, :index, :show, :destroy] do
resources :post_comments, only: [:create]
end
   

#adminの設定
namespace :admin do

root to: '/admin/homes#top'


    resources :users, :categories, :posts, :details
  end
  


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
