Rails.application.routes.draw do
  root 'report#index'
  get 'report/index'

  resources :categories, expect: [:show]

  devise_for :users
end
