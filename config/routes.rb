Rails.application.routes.draw do
  # devise_for :accounts
  devise_for :accounts, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/accounts/sessions',
    registrations: 'api/v1/accounts/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :accounts
      resources :customers
      resources :admins
      resources :sales
      resources :categories
      resources :products
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
