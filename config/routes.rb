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
  post "sessions/logout_hook"

  post "mailer/comment"

  root :to => "rides#index"

  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post]
  match '/auth/failure', :to => 'sessions#failure', via: [:get, :post]

end
