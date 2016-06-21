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

  resources :orders do
    get :pay, on: :collection
  end

  namespace :admin do
    get 'home'                 => 'home#index'
    get 'products_recommended' => 'products_recommended#index'

    resources :users
    resources :products
    resources :shelf_items do
      collection do
        get :pull_off_shelf    # ajax get request
        get :on_shelf_list
        get :off_shelf_list
      end
    end
    resources :product_categories
    resources :product_labels
    resources :projects
    resources :project_types
    resources :support_types
    resources :donations
    resources :banners
  end

  scope 'wepay' do
    get '/jsapi/',          to: 'wepay#recv'
    get '/unified_order',   to: 'wepay#unified_order'
    get '/init_wx_js_info', to: 'wepay#init_wx_js_info'
    get '/init_jspay_info', to: 'wepay#init_jspay_info'
  end
end
