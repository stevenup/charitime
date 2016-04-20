Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root 'home#index'
  get 'demo/index'

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

  end

end