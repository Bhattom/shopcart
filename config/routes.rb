Rails.application.routes.draw do
  get 'categories/new'
  get 'categories/create'
  resources :products do
    post '/update_quantity', to: 'products#update_quantity'
    collection do
      get '/products', to: 'products#product', as: 'products'
      get 'products/products', to: 'products#next_batch', as: 'products_products'

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


  resources :orders do
    get '/status', to: 'orders#status', as: 'status'
  end
  resources :addresses

  devise_for :users, controllers: { registrations: 'users/registrations',
    sessions: 'users/sessions'}
  devise_scope :user do
    get '/verify_user', to: 'devise/sessions#verify'
  end

  get 'enable_otp_show_qr', to: 'users#enable_otp_show_qr', as: 'enable_otp_show_qr'
  post 'enable_otp_verify', to: 'users#enable_otp_verify', as: 'enable_otp_verify'

  get 'users/otp', to: 'users#show_otp', as: 'user_otp'
  post 'users/otp', to: 'users#verify_otp', as: 'verify_user_otp'
  post 'verify_otp', to: 'users/sessions#verify_otp'
  
  root to: "products#index"
  resources :payments, only: [:create, :show, :new] do
    collection do
      post '/create_payment', to: 'payments#create_payment'
      post 'payment_callback'
      get '/success', to: 'payments#success', as: 'success'
      get '/offline_payment', to: 'payments#offline_payment', as: 'offline_payment'
      get '/invoice_print', to: 'payments#invoice_print', as: 'invoice_print'
      get 'download_pdf'
      post '/update_status', to: 'payments#update_status'
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
