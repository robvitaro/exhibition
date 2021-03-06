Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show] do
    resources :works
    resources :galleries
  end

  root 'users#index'

end
