Rails.application.routes.draw do
  root to: 'posts#index'

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy] do
    get 'posts'
    get 'comments'
  end

  resources :posts do
    resources :comments, only: :create
  end
end
