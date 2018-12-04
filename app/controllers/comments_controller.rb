class CommentsController < ApplicationController
  def create
    @ride = Ride.find(params[:ride_id])
    @comment = @ride.comments.create(params[:comment].permit("comment", "commit", "ride_id"))
    redirect_to ride_path(@ride)
  end

  def destroy
    @ride = Ride.find(params[:ride_id])
    @comment = @ride.comments.find(params[:id])
    @comment.destroy
    redirect_to ride_path(@ride)
  end
end
