Rails.application.routes.draw do
  root to: 'recipes#index'
  devise_for :users
  resources :recipes
end
