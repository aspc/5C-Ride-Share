require 'httparty'

class SessionsController < ApplicationController
  def new
  end

  def create_new_account
    email = params[:email]
    user = User.find_by(:email => email)

    if(user)
      return redirect_to login_url,
                         :flash => {
                             :notice => "Cannot create account",
                             :notice_subtitle => "Account with provided email already exists.",
                             :notice_class => "is-danger",
                         }
    end

    school = params[:school]
    name = params[:name].titleize
    password = SessionsService.encrypt_password(params[:password])
    user = User.new({
                        :email => email,
                        :password => password,
                        :name => name,
                        :school => school,
                        :is_cas_authenticated => false
                    })

    if not user.save
      return redirect_to login_url,
                         :flash => {
                             :notice => "Cannot create account",
                             :notice_subtitle => "Please fill out all fields to create your account.",
                             :notice_class => "is-danger",
                         }
    end

    session[:current_user_id] = user.id
    redirect_to root_url, :notice => "Account created. Welcome, #{current_user.name}."
  end

  def create_via_credentials
    email = params[:email]
    password = params[:password]
    user = SessionsService.authenticate_account(email, password)

    if(!user)
      return redirect_to login_url,
                         :flash => {
                             :notice => "Cannot sign in",
                             :notice_subtitle => "An account with that email address and password combination was not found.",
                             :notice_class => "is-danger"
                         }
    end

    session[:current_user_id] = user.id
    redirect_to root_url, :notice => "Login successful. Welcome, #{current_user.name}."
  end

  def create_via_cas
    next_page = '/'
    service_url = 'https://' + 'aspc.pomonastudents.org/5crideshare' + Rails.application.routes.url_helpers.login_cas_path + '?next=' + CGI::escape(next_page)
    ticket = params[:ticket]

    # if request doesn't have CAS Ticket, direct them there
    return redirect_to _login_url(service_url) unless ticket

    # otherwise attempt login
    begin
      user_info = SessionsService.authenticate_ticket(ticket, service_url)
    rescue
      return redirect_to login_url,
                         :flash => {
                             :notice => "Authentication Failed",
                             :notice_subtitle => "Your school might not yet allow you to authenticate against CAS for this website",
                             :notice_class => "is-danger"
                         }
    end

    # if CAS Ticket is invalid, redirect to CAS ticketing system
    return redirect_to _login_url(service_url) unless user_info

    # otherwise, login was successful, so
    # find or create user from login data
    user = User.find_by(:email => user_info[:email])
    if user.nil?
      user = User.create({
                             :email => user_info[:email],
                             :name => user_info[:name],
                             :is_cas_authenticated => true,
                             :school => User.schools[:pomona]
                         })
    end

    # then create the login session for the user
    session[:current_user_id] = user.id

    # return redirect_to PHP_AUTH_URL
    redirect_to root_url, :notice => "Login successful. Welcome, #{current_user.name}."
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

    session[:time] = Time.now.utc
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
    session[:current_user_id] = nil
    redirect_to root_url
  end

  def logout_hook
    token = params[:logout_token]

    data = {
      body: {
        logout_token: token,
        app_id: APP_ID,
        app_secret: APP_SECRET
      }
    }

    response = HTTParty.post('https://clef.io/api/v1/logout', data)

    if response['success']
      @user = User.find_by_clef_id(response['clef_id'].to_s)
      @user.logged_out_at = Time.now.utc
      @user.save
    end

    render :nothing => true
  end

  def failure
  end

  def _login_url(service_url)
    query_params = {
        :service => service_url
    }

    cas_server_url = Rails.configuration.CAS_SERVER_URL
    puts [cas_server_url, 'login'].join('/') + '?' + query_params.to_query.to_s
    [cas_server_url, 'login'].join('/') + '?' + query_params.to_query.to_s
  end
end
