Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        get 'find', on: :collection
        get 'find_all', on: :collection
        get 'random', on: :collection
        get 'items', on: :member
        get 'invoices', on: :member
      end

      resources :customers, only: [:index, :show] do
        get 'find', on: :collection
        get 'find_all', on: :collection
        get 'random', on: :collection
      end

      resources :invoices, only: [:index, :show] do
        get 'find', on: :collection
        get 'find_all', on: :collection
        get 'random', on: :collection
        get 'transactions', on: :member
        get 'invoice_items', on: :member
        get 'items', on: :member
        get 'customer', on: :member
        get 'merchant', on: :member
      end

      resources :items, only: [:index, :show] do
        get 'find', on: :collection
        get 'find_all', on: :collection
        get 'random', on: :collection
        get 'invoice_items', on: :member
      end

      resources :invoice_items, only: [:index, :show] do
        get 'find', on: :collection
        get 'find_all', on: :collection
        get 'random', on: :collection
        get 'invoice', on: :member
        get 'item', on: :member
      end

      resources :transactions, only: [:index, :show] do
        get 'find', on: :collection
        get 'find_all', on: :collection
        get 'random', on: :collection
      end
    end
  end
end
