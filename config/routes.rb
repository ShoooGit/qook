Rails.application.routes.draw do
  root to: 'recipes#index'
  devise_for :users
  resources :recipes do
    member do
      patch 'execute'
    end
    collection do
      get 'search'
    end
  end
  resources :refrigerators, only: [:new, :create, :edit, :update]
end
