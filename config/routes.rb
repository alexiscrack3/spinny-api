Rails.application.routes.draw do
  namespace :admin do
    get 'clubs', to: 'clubs#index'
  end
  resources :clubs, only: %i[show create update destroy]
  resources :players

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/graphql', to: 'graphql#execute'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine,
          at: '/graphiql',
          graphql_path: 'graphql#execute'
  end
end
