Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'  
  get '/users', to: 'users#index'
  get '/users/saved', to: 'saved_posts#index'
  post '/users/saved', to: 'saved_posts#create'
  delete '/users/saved/:id', to: 'saved_posts#destroy'
  get '/users/:id', to: 'users#detail'
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
  get 'posts/categories', to: 'categories#index'
  post 'posts/categories', to: 'categories#create'
  delete 'posts/categories/:id', to: 'categories#destroy'
  get 'posts/:id', to: 'posts#detail'
  post 'posts', to:'posts#create'
  delete 'posts/:id', to: 'posts#destroy'


  get 'posts/:id/comments', to: 'comments#post_index'
  post 'posts/:id/comments', to: 'comments#create'
  delete 'posts/:id/comments/:com_id', to: 'comments#destroy'

  get 'subscriptions/:id', to: 'subcribtions#subscriptions'
  get 'subscribers/:id', to: 'subcribtions#subscribers'
  post 'subscriptions', to: 'subcribtions#create'
  delete 'subscriptions/:id', to: 'subcribtions#destroy'


end
