Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'  
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'posts', to: 'posts#index'
  get 'posts/:id', to: 'posts#detail'
  post 'posts', to:'posts#create'
end
