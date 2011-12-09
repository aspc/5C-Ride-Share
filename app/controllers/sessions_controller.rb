class SessionsController < ApplicationController
  def login
    unless request.env["HTTP_REFERER"]
      session[:redirect_to] = request.env["HTTP_REFERER"]
    else
      session[:redirect_to] = root_url
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
      if session[:redirect_to]
        redirect_to session[:redirect_to], :notice => "Congratulations! You successfully signed in!"
      else
        redirect_to root_url
      end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
  def failure
  end
end
