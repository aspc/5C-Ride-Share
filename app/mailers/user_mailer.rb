class UserMailer < ActionMailer::Base
  default :from => "5C Ride Share <5crideshare@gmail.com>"
  
  def new_rider_email(user, rider, rideurl)
    @user = user
    @rider = rider
    @url = rideurl
    mail(:to => user.email, :subject => "#{rider.name} joined your 5C ride!")
  end
  
  def new_comment_email(user, commenter, rideurl)
    @user = user
    @commenter = commenter
    @url = url
    mail(:to user.email, :subject => "#{commenter.name} commented on your 5C ride!")
  end
end
