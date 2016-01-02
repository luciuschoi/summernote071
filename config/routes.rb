Rails.application.routes.draw do

  root 'posts#index'
  post 'uploads' => 'uploads#create'
  resources :posts

end
