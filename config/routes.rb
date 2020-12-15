Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }


  root to: 'posts#index'

  # post '/posts/guest_sign_in', to: 'posts#new_guest'
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :posts do
    resources :comments, only: :create
  end

  resources :users do
    resource :follow
    resources :followings
    resources :followers
  end

  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

end
