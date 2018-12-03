Shuttleshare::Application.routes.draw do
  root :to => 'rides#index'

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

  scope controller: :sessions do
    get   'unauthorized' => :not_authorized
    get   'login' => :new
    match 'logout' => :destroy, :via => [:get, :destroy]
    match 'login/cas' => :create_via_cas, :via => [:get, :post]
    match 'login/credentials' => :create_via_credentials, :via => [:get, :post]
    match 'login/create_account' => :create_new_account, :via => [:get, :post]
  end

  post 'mailer/comment'

  #match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post]
  #match '/auth/failure', :to => 'sessions#failure', via: [:get, :post]
end
