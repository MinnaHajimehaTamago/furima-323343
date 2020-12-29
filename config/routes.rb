Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: 'items#index'
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: [:create]
    collection do
      get 'tag_search'
      get 'category_search_index'
      get 'category_search_result'
    end
  end
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
end
