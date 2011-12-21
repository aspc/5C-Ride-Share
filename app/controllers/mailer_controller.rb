class MailerController < ApplicationController
  def comment
    url = params[:url]
    ride_id = url.split("/").last
    ride = Ride.find(ride_id)
    commenter = User.find(params[:c_id])
    users = ride.users.collect {|user| user if user.id != commenter.id}
    users.each do |user|
      if user
        if user.email && user.email_pref
          UserMailer.new_comment_email(commenter, user, url).deliver
        end
      end
    end
    render :nothing => true
  end
end
