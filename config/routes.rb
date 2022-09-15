Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers, only: %i[] do
        resources :subscriptions, only: %i[create destroy index]
      end
    end
  end
end
