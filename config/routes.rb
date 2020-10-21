Rails.application.routes.draw do
  root to: 'recipes#index'
  devise_for :users do
    resources :refrigerators, only[:index]
  end
  resources :recipes
end
