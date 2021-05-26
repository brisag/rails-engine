Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, controller: :merchant_items, only: [:index]
      end
      resources :items do
        resources :merchant, controller: :items_merchant, only: [:index]
      end
      resources :items
      namespace :revenue do
        resources :merchants, only: [:show]
      end
    end
  end
end


# get "/api/v1/items/#{@item.id}/merchant"
