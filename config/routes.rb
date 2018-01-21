Rails.application.routes.draw do
  root 'report#index'
  resources :report, only: :index do
    get 'search', on: :collection
  end

  resources :categories, except: [:show]
  resources :incomes
  resources :expenses

  devise_for :users
end
