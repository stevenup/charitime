Rails.application.routes.draw do
  get 'products' => 'products#index'
  get 'products/detail'

  mount Ckeditor::Engine => '/ckeditor'

  root 'home#index'
  get 'demo/index'

  resources :home, only: [:index] do
    get :personal_center,   on: :collection
    get :donations_center,  on: :collection
    get :my_gyb,            on: :collection
    get :project_detail,    on: :collection
    get :product_detail,    on: :collection
    get :donate_page,       on: :collection
  end

  resources :donations

  resources :products do
    member do
      get :index
      get :detail
    end
  end

  namespace :admin do
    get 'home' => 'home#index'
    get 'products_recommended' => 'products_recommended#index'

    resources :users
    resources :products do
      get 'set_recommended', on: :collection
      get 'reset_recommended', on: :collection
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