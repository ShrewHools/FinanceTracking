Rails.application.routes.draw do
  root 'report#index'
  get 'report/index'

  devise_for :users
end
