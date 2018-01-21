Rails.application.routes.draw do
  root 'report#index'
  get 'report/index'

  resources :categories, except: [:show]

  devise_for :users
end
