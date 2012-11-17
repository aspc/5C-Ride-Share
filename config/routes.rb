Shuttleshare::Application.routes.draw do
  resources :rides do
    collection do
      get 'join'
      get 'leave'
      get 'airport'
    end
  end

  resources :users do
    collection do
      get 'unsubscribe'
      get 'login'
    end
  end

  get "sessions/create"
  get "sessions/destroy"
  get "sessions/login"

  post "mailer/comment"

  root :to => "Rides#index"

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

end
