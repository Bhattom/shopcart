Rails.application.routes.draw do
  resources :products do
    post '/update_quantity', to: 'products#update_quantity'
    resources :similar_products
  end 
  resources :carts do
    resources :lineitems
  end
  resources :carts do
    post 'add_to_cart', on: :collection
  delete 'remove_item', on: :member
  end
  resources :lineitems do
    patch 'increase_quantity', on: :member
    patch 'decrease_quantity', on: :member
    patch 'increase_stk', on: :member
    patch 'decrease_stk', on: :member
  end
  devise_for :users
  root to: "products#index"
  resources :users do
     collection do
       get 'user'
       get 'userinfo'
     end
  end
end
