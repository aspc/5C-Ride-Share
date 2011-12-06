Shuttleshare::Application.routes.draw do
  resources :rides do
    collection do
      get 'join'
      get 'ontario'
      get 'lax'
    end
  end
  
  get "sessions/create"
  get "sessions/destroy"
  
  root :to => "Rides#index"
  
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/:provider/failure', :to => 'sessions#failure'

end
