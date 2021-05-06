Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources :books, only: :index do
    resources :orders, only: :create
  end
  resources :orders, only: :index
  resources :books
  delete 'order/:id', to: 'orders#destroy', as: 'destroy_order'
  delete 'orders/clean', to: 'orders#clean', as: 'clean_orders'

  resources :billings, only: [] do
    collection do
      get 'pre-pay'
      get 'execute'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
