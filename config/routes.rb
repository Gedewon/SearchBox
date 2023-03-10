Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :user, only: :index, defaults: { format: 'json' }
      resources :search, only: :index, defaults: { format: 'json' }
    end
  end
  root 'root#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
