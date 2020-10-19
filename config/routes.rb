Rails.application.routes.draw do
  root to: 'recipes#index'
  devise_for :users
  resources :recipes, only: [:index, :new, :create, :show, :edit, :update]
end
