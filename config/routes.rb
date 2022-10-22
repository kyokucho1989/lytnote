Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "landings#index"
  resources :plans, except: :show
  resources :reports
  resources :report_items, only: [:index, :destroy]
  resources :genres, except: :show
  resources :reviews do
    collection do
      get 'change_state'
    end
  end

  get '*not_found' => 'application#page_not_found'
end
