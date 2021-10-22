Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "plans#index"
  resources :plans
  resources :reports
  resources :report_items, only: [:index, :destroy]
  resources :genres, except: :show
  resources :reviews do
    member do
      get 're_select_plan'
    end

    collection do
      get 'select_plan'
    end
  end
end
