class CommentsController < ApplicationController
  before_filter :login_helper, :only => [:create, :destroy]

  def create
    @ride = Ride.find(params[:ride_id])
    @comment = @ride.comments.create(params[:comment].permit("comment", "commit", "ride_id", "user_id"))
    redirect_to ride_path(@ride)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @ride = @comment.ride

    if @comment.user_id == @current_user.id
      @comment.destroy
    end

    redirect_to ride_path(@ride)
  end
end
