Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations' # 追加
  }
  root to: "homes#top"
  get "home/about", to: "homes#about"
  resources :users, only: [:index, :show, :create, :edit, :update]
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
end
