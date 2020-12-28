Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items do
    resources :orders, only: [:index, :create]
    collection do
      get 'tag_search'
      get 'category_search_index'
      get 'category_search_result'
    end
  end
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
end
