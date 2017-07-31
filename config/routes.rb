Rails.application.routes.draw do
  # devise_for :users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { confirmations: 'confirmations' },
    path: '', path_names: { sign_in: 'login', sign_out: 'logout', edit: 'settings'}
  ActiveAdmin.routes(self)

  get '/search', to: 'search#search'

  resource :feed, only: [:show]
  resources :tags, only: [:show] do
    get 'fetch', on: :collection
  end

  resources :users, only: [:update, :edit, :show] do
    resources :albums do
      resources :photos do
        resources :comments, only: [:create, :destroy]
      end
    end

    resources :followerships, only: [:create, :destroy]
    resources :following, only: :index
    resources :followers, only: :index
  end


  root to: 'homepage#index'

  mount ActionCable.server => '/cable'
end
