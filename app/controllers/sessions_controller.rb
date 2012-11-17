require 'httparty'

APP_ID = '2d49c49704fa906d75938d86da05e957'
APP_SECRET = '2dc6d85c42ecca9d1f4514770193abd2'
class SessionsController < ApplicationController
  def login
    unless request.env["HTTP_REFERER"].blank?
      session[:redirect_to] = request.env["HTTP_REFERER"]
    end
    redirect_to '/auth/facebook'
  end

  def create
    if params[:provider] == 'clef'
      code = params[:code]
      response = HTTParty.post("https://clef.io/api/authorize", { body: { code: code, app_id: APP_ID, app_secret: APP_SECRET} })
      if response['success']
        response = HTTParty.post("https://clef.io/api/info", { body: {access_token: response['access_token']} })
        @user = User.find_or_create_by_clef_id(response)
      else
        redirect '/auth/failure'
      end
    else
      auth = request.env['omniauth.auth']
      unless @user = User.find_from_hash(auth)
        # Create a new user or add an auth to existing user, depending on
        # whether there is already a user signed in.
        @user = User.create_from_hash!(auth)
      end
      # Log the authorizing user in.
    end

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
