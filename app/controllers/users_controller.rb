class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :show]

  def edit
    @title = "5C Rideshare :: settings"
  end

  def update
    if @current_user.update_attributes(user_params)
      redirect_to edit_user_path(@current_user), :notice => "Your user information was successfully updated."
    else
      redirect_to :action => 'edit'
    end
  end

  def show
    @title = "5C Rideshare :: your rides"
    rides = @current_user.rides
    @arrivals = []
    @departures = []
    rides.each do |ride|
      if ride.airport == "From Ontario" or ride.airport == "From LAX"
        @arrivals << ride
      else
        @departures << ride
      end
    end
    @arrivals = sort_rides(@arrivals)
    @departures = sort_rides(@departures)
  end

  def unsubscribe
    email = params[:id]
    if email
      user = User.find_by_email(email)
      if user
        user.email_pref = false
        user.save
        redirect_to root_url, :notice => "Successfully unsubscribed from email notifications"
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

  protected

    helper_method :correct_user

    def correct_user
      redirect_to root_url unless @current_user && params[:id] == @current_user.id.to_s
    end

    def user_params
      if params[:user]
        params.require(:user).permit(:name, :email, :email_pref)
      end
    end
end
