Rails.application.routes.draw do
  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      get 'orders/get_last_week_orders', to: 'orders#get_last_week_orders'
      post 'orders/new', to: 'orders#create'
      get 'orders/:id', to: 'orders#show'
      patch 'orders/:id', to: 'orders#update'
      get 'orders/get_last_week_orders', to: 'orders#get_last_week_orders'
    end
  end
end
