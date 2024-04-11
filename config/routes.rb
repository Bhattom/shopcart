Rails.application.routes.draw do
  get 'categories/new'
  get 'categories/create'
  resources :products do
    post '/update_quantity', to: 'products#update_quantity'
    collection do
      get '/products', to: 'products#product', as: 'products'
    end
    resources :similar_products
    collection do
      get 'filtered'
    end
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
  resources :categories 


  resources :orders
  resources :addresses
  devise_for :users
  root to: "products#index"
  resources :payments, only: [:create, :show, :new] do
    collection do
      post 'create_payment'
      post 'payment_callback'
      get '/success', to: 'payments#success', as: 'success'

    end
  end
  post '/payments/create_payment/:order_id', to: 'payments#create_payment', as: 'create_payment'
  resources :razorpay, only: [:create_payment, :payment_callback]
  resources :users do
     collection do
       get 'user'
       get 'userinfo'
     end
  end
end
