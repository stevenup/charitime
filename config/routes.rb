Rails.application.routes.draw do
  root 'home#index'

  resources :home, only: [:index] do
    get :personal_center,   on: :collection
    get :donations_center,  on: :collection
    get :my_gyb,            on: :collection
    get :product_detail,    on: :collection
  end
end
