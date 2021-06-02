Rails.application.routes.draw do
  post 'login' => 'users#login'
  post 'user' => 'users#create'
  get 'user' => 'users#index'
  get 'user/:id' => 'users#show'
  delete 'user/me' => 'users#destroy'

  post 'post' => 'posts#create'
  #resources :users
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
