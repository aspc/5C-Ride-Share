class SessionsController < ApplicationController
  def login
    unless request.env["HTTP_REFERER"].blank?
      session[:redirect_to] = request.env["HTTP_REFERER"]
    end
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
      unless session[:redirect_to].blank?
        begin
          redirect_to session[:redirect_to], :notice => "Congratulations! You successfully signed in!"
        rescue ActionController::RedirectBackError
          redirect_to root_url, :notice => "Congratulations! You successfully signed in!"
        end
      else
        redirect_to root_url, :notice => "Congratulations! You successfully signed in!"
      end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
  def failure
  end
end
