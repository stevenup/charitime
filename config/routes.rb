Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]

  mount Ckeditor::Engine => '/ckeditor'
  mount ChinaCity::Engine => '/china_city'

  root 'home#index'

  resources :home, only: [:index] do
    get :personal_center,  on: :collection
    get :donations_center, on: :collection
    get :my_gyb,           on: :collection
    get :donate_page,      on: :collection
    get :my_address,       on: :collection
  end

  resources :shelf_items

  resources :projects do
    member do
      get :index
    end
  end

  resources :donations
  resources :addresses

  resources :orders, except: [:show] do
    get :cancel_order, on: :member
    get :apply_refund, on: :member
  end
  get '/orders/pay/:id', to: 'orders#pay', as: 'order_pay'

  namespace :admin do
    get 'home'                 => 'home#index'

    resources :users
    resources :products

    resources :shelf_items do
      get :pull_off_shelf,     on: :member
      get :set_recommended,    on: :member
      get :reset_recommended,  on: :member
      collection do
        get :on_shelf_list
        get :off_shelf_list
        get :recommended_list
      end
    end
    resources :product_categories
    resources :product_labels
    resources :projects
    resources :project_types
    resources :support_types
    resources :donations
    resources :banners
    resources :orders do
      collection do
        get :refund_orders
        get :undelivered_orders
      end
    end
  end

  scope 'wepay' do
    get '/jsapi/',          to: 'wepay#recv'
    get '/unified_order',   to: 'wepay#unified_order'
    get '/refund_order',    to: 'wepay#refund_order'
    get '/init_wx_js_info', to: 'wepay#init_wx_js_info'
    get '/init_jspay_info', to: 'wepay#init_jspay_info'
    get '/get_logistics',   to: 'wepay#get_logistics'
    post '/notify',         to: 'wepay#notify'
  end
end
