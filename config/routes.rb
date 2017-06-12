Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' },
    path: '', path_names: { sign_in: 'login', sign_out: 'logout', edit: 'settings'}

  get 'tags/search', to: 'tags#search'

  resources :users, only: [:update, :edit, :show], path: '/' do
    member do
      get 'followers'
      get 'following'
    end

    resources :albums do
      resources :photos do
        resources :comments, only: [:create, :destroy]
      end
    end

    resources :followerships, only: [:create, :destroy]
  end

  root to: 'homepage#index'
end
