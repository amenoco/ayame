Rails.application.routes.draw do

  
# 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
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

    get '/customers/my_page' => 'customers#show', as: 'my_page'
    get '/customers/infomation/edit' => 'customers#edit', as: 'customers_edit'
    patch '/customers/infomation' => 'customers#update', as: 'infomation'
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'

    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'

    post '/orders/confirm' => 'orders#confirm', as: 'confirm'
    get '/orders/complete' => 'orders#complete', as: 'complete'


    resources :items, :cart_items, :orders, :addresses
    

  resources :cart_items do
    collection do
      delete 'destroy_all'
    end
  end
  end



#adminの設定
namespace :admin do

root to: '/admin/homes#top'


    resources :items, :genres, :customers, :orders, :orders_details
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
