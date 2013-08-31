PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'

  resources :users, only: [:create]
  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end
  resources :categories, only: [:new, :create]

end
