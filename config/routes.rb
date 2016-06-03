Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        collection do
          get 'find'
          get 'find_all'
          get 'random'
          scope module: "merchants" do
            get 'most_revenue', to: "most_revenue#index"
            get 'most_items', to: "most_items#index"
            get 'revenue', to: "revenue#index"
          end
        end
        member do
          get 'items'
          get 'invoices'
          scope module: "merchant" do
            get "revenue", to: "revenue#index"
          end
        end
      end

      resources :customers, only: [:index, :show] do
        get 'find', on: :collection
        get 'find_all', on: :collection
        get 'random', on: :collection
        get 'invoices', on: :member
        get 'transactions', on: :member
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
        get 'merchant', on: :member
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
        get 'invoice', on: :member
      end
    end
  end
end
