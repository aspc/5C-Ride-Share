class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :show]
  
  def edit
    @title = "5C ride share :: settings"
  end
  
  def update
    if @current_user.update_attributes(params[:user])
      redirect_to edit_user_path(@current_user), :notice => "Your user information was successfully updated."
    else
      redirect_to :action => 'edit'
    end
  end
  
  def show
    @title = "5C ride share :: your rides"
    @rides = @current_user.rides
  end
  def rides
  end
  
  protected
  
    helper_method :correct_user
    
    def correct_user
      redirect_to root_url unless @current_user && params[:id] == @current_user.id.to_s
    end
end
