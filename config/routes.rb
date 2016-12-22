Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount ChinaCity::Engine => '/china_city'

  devise_for :admin, controllers: {
  :sessions => "admin/sessions"
  }

  root 'home#index'

  resource :wechat, only: [:show, :create]

  resources :home, only: [:index] do
    get :personal_center,  on: :collection
    get :donations_center, on: :collection
    get :donate_page,      on: :collection
    get :my_address,       on: :collection
  end


  resources :carousels, only: [:detail] do
    get :detail, on: :member
  end

  get 'gybs' => 'gybs#index'
  get 'gybs/append'
  get 'gybs/exchange'

  resources :supports
  get '/supports/pay/:id', to: 'supports#pay', as: 'support_pay'

  resources :shelf_items
  get '/update_order_address' => 'shelf_items#update_order_address'

  resources :projects do
    member do
      get :detail
    end
  end

  resources :donations
  resources :addresses do
    get :modify,      on: :collection
    get :set_default, on: :member
  end

  resources :orders do
    get :cancel_order,           on: :member
    get :apply_refund,           on: :member
    get :confirm_complete,       on: :member
    get :add_gyb_payment_record, on: :collection
  end
  get '/orders/pay/:id', to: 'orders#pay', as: 'order_pay'

  namespace :admin do
    root :to => 'home#index'
    get 'home' => 'home#index'

    resources :users

    resources :carousels do
      get :preview,   on: :member
      get :publish,   on: :member
      get :depublish, on: :member
    end

    resources :products do
      get :preview, on: :member
    end

    resources :gybs

    resources :shelf_items do
      get :pull_off_shelf,    on: :member
      get :set_recommended,   on: :member
      get :reset_recommended, on: :member
      collection do
        get :on_shelf_list
        get :off_shelf_list
        get :recommended_list
      end
    end

    resources :product_categories
    resources :product_labels

    resources :projects do
      member do
        get :preview
        get :publish
        get :depublish
        get :recommend
        get :reset_recommend
      end
      collection do
        get :all
        get :recommended_projects
      end
    end

    resources :donations

    resources :orders do
      collection do
        post :update
        get :query
        get :refund_orders
        get :undelivered_orders
        post :get_excel, :defaults => { :format => 'xlsx' }
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
