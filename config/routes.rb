Shuttleshare::Application.routes.draw do
  resources :rides do
    collection do
      get 'join'
      get 'leave'
      get 'toontario'
      get 'tolax'
      get 'fromontario'
      get 'fromlax'
    end
  end
  
  get "sessions/create"
  get "sessions/destroy"
  get "sessions/login"
  
  root :to => "Rides#index"
  
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

end
