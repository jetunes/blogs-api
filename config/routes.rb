Rails.application.routes.draw do
  post 'login' => 'users#login'
  post 'user' => 'users#create'
  get 'user' => 'users#index'
  get 'user/:id' => 'users#show'
  delete 'user/me' => 'users#destroy'

  post 'post' => 'posts#create'
  get 'post/search' => 'posts#search'
  get 'post' => 'posts#index'
  get 'post/:id' => 'posts#show'
  put 'post/:id' => 'posts#update'
  delete 'post/:id' => 'posts#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
