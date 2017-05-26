Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' },
    path: '', path_names: { sign_in: 'login', sign_out: 'logout', edit: 'settings'}

  resources :tags, only: [:index]

  resources :users, only: [:update, :edit, :show], path: '/'

  root to: 'homepage#index'
end
