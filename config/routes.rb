Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]

  mount Ckeditor::Engine => '/ckeditor'

  root 'home#index'

  resources :home, only: [:index] do
    get :personal_center, on: :collection
    get :donations_center, on: :collection
    get :my_gyb, on: :collection
    get :donate_page, on: :collection
  end

  resources :products do
    get :detail, on: :member
  end

  resources :projects do
    member do
      get :index
    end
  end

  resources :donations

  namespace :admin do
    get 'home' => 'home#index'
    get 'products_recommended' => 'products_recommended#index'

    resources :users
    resources :products do
      get 'set_recommended', on: :collection
      get 'reset_recommended', on: :collection
    end
    resources :shelf_items do
      collection do
        get :put_on_shelf    # ajax get request
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

end