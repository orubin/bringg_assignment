Rails.application.routes.draw do
  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      post 'orders/new', to: 'orders#create'
      get 'orders/:id', to: 'orders#show'
      patch 'orders/:id', to: 'orders#update'
    end
  end
end
