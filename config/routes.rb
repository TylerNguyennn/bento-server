Rails.application.routes.draw do
  get "private/test"
  get '/current_user', to: 'current_user#index'
  post 'google_oauth', to: 'users/google_oauth#create'


  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks' 
    }

  resources :products
end
