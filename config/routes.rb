Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "plans#index"
  resources :plans
  resources :reports
  resources :report_items, only: :destroy
  resources :reviews
end
