Rails.application.routes.draw do
  root to: 'recipes#index'
  devise_for :users
  resources :recipes do
    collection do
      post 'execute'
    end
  end
  resources :refrigerators, only: [:new, :create, :edit, :update]
end
