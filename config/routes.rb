Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        get 'find', on: :collection
      end
    end
  end
end
