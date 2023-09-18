Rails.application.routes.draw do
  resources :articles
  resources :feeds
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  resources :sandbox, only: [ :index, :show ]
  resources :dashboard, only: [ :index ]
  # Defines the root path route ("/")
  # root "articles#index"
end
