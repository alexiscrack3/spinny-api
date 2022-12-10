require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :players
  namespace :admin do
    get 'clubs', to: 'clubs#index'
  end
  resources :players
  resources :clubs, only: %i[show create update destroy]
  resources :games, only: %i[show create update destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/graphql', to: 'graphql#execute'
  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'

    mount GraphiQL::Rails::Engine,
          at: '/graphiql',
          graphql_path: 'graphql#execute'
  end
end
