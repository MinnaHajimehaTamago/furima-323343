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
      get 'search'
      get 'tag_suggestion'
      get 'category_search_index'
      get 'category_search_result'
      get 'tag_search_index'
      get 'tag_search_result'
    end
  end
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create, :edit, :update, :destroy]
end
