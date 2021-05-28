Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/v1/merchants/find_all', to: 'api/v1/merchants/search#index'
  get '/api/v1/items/find', to: 'api/v1/items/search#index'
  namespace :api do
    namespace :v1 do
      #merchants  index+show and merchant_items items index
      resources :merchants, only: [:index, :show] do
        resources :items, controller: :merchant_items, only: [:index]
      end
      #all items actions and items_merchant index
      resources :items do
        resources :merchant, controller: :items_merchant, only: [:index]
      end
      #Non RESTful routes Section 3
      namespace :revenue do
        resources :merchants, only: [:index, :show]
        resources :unshipped, only: [:index]
        resources :items, only: [:index]
      end
  #     #Non-RESTful Search Endpoints Section 2
  #     # namespace :merchants do
      #   resources :find_all, controller: :search, only: :index
      # end
      # namespace :items do
      #   resources :find, controller: :search, only: :index
      # end
    end
  end
end
