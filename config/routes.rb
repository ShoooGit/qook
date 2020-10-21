Rails.application.routes.draw do
  get 'refrigerators/index'
  root to: 'recipes#index'
  devise_for :users
  resources :recipes
end
