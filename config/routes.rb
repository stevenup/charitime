Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root 'home#index'
  get 'demo/index'

  resources :home, only: [:index]

  namespace :admin do
    resources :home, only: [:index]
    resources :users
    resources :products
    resources :products_recommended
    resources :product_categories
    resources :product_labels
    resources :projects
    resources :project_types
    resources :support_types
    post 'set_recommended', to: 'products#set_recommended'
  end

end