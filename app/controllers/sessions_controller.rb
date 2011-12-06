class SessionsController < ApplicationController
  def login
    session[:redirect_to] = :back
    redirect_to '/auth/facebook'
  end
  
  def create
    auth = request.env['omniauth.auth']
      unless @user = User.find_from_hash(auth)
        # Create a new user or add an auth to existing user, depending on
        # whether there is already a user signed in.
        @user = User.create_from_hash!(auth)
      end
      # Log the authorizing user in.
      self.current_user = @user
      redirect_to session[:redirect_to]
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to :back
  end
end
