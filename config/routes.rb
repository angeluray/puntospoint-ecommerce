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

end
