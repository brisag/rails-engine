Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
      #Non-RESTful Search Endpoints

    end
  end
end
