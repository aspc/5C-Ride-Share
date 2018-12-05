class CommentsController < ApplicationController
  before_filter :login_helper, :only => [:create, :destroy]

  def create
    @ride = Ride.find(params[:ride_id])
    @comment = @ride.comments.create(params[:comment].permit("comment", "commit", "ride_id", "user_id"))
    redirect_to ride_path(@ride)
  end

  def destroy
    @ride = Ride.find(params[:ride_id])
    @comment = @ride.comments.find(params[:id])
    if @comment.user_id == session["current_user_id"]
      @comment.destroy
    end
    redirect_to ride_path(@ride)
  end
end
