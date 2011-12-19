class UsersController < ApplicationController
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
end
