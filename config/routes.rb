Rails.application.routes.draw do
  
  # devise_for :admins
  devise_for :admins, path: '', path_names: {
    sign_in: 'admin_login',
    sign_out: 'admin_logout',
    registration: 'admin_signup'
  },
  controllers: {
    sessions: 'api/v1/admins/sessions',
    registrations: 'api/v1/admins/registrations'
  }

  devise_for :customers

  namespace :api do
    namespace :v1 do
      resources :accounts do
        resources :products
        resources :categories
        resources :sales
      end

      resources :categories do
        resources :sales
      end

      resources :products do
        resources :sales
      end

      resources :sales
      
      get '/purchases_registry', to: 'categoriess#purchases_registry'
      get '/earnings_registry', to: 'categories#purchases_granularity_search'

      get '/purchases_registry_search', to: 'sales#purchases_registry_search'
      get '/purchases_granularity_search', to: 'sales#purchases_granularity_search'
    end
  end

end
