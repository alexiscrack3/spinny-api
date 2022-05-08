Rails.application.routes.draw do
  resources :clubs
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
