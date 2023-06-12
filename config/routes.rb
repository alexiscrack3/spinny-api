require 'sidekiq/web'

Rails.application.routes.draw do
  scope '/api' do
    devise_for :players, path: 'players', path_names: {
      sign_in: 'sign_in',
      sign_out: 'sign_out',
      registration: 'sign_up'
    },
    controllers: {
        sessions: 'sessions',
        registrations: 'registrations'
    }
    namespace :admin do
      get 'clubs', to: 'clubs#index'
    end

    get 'players/me', to: 'players#me'
    resources :players, only: %i[index show update]

    resources :clubs do
      get :members, to: 'clubs#members'
      post :members, to: 'clubs#join'
      delete :members, to: 'clubs#leave'
    end
    resources :games, except: %i[index]

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
end
