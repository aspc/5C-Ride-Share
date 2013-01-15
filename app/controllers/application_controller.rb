class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user

  def sort_rides(rides)
    rides.sort! {|a,b| a.flighttime <=> b.flighttime}
    rides = rides.find_all{|ride| ride.flighttime > Time.now}
  end
  protected

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def signed_in?
      !!current_user
    end

    def checker
      unless current_user
        redirect_to root_url
      end
    end

    def login_helper
      unless current_user
        session[:redirect_to] = :back
        redirect_to '/users/login'
      end
    end

    helper_method :current_user, :signed_in?, :checker

    def current_user=(user)
      @current_user = user
      session[:user_id] = user.id
    end
end
