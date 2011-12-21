class UserMailer < ActionMailer::Base
  default :from => "5C Ride Share <5crideshare@gmail.com>"
  
  def new_rider_email(user, rider, rideurl)
    @user = user
    @rider = rider
    @url = rideurl
    @email = user.email
    @host = "localhost:3000"
    mail(:to => @email, :subject => "#{rider.name.split(" ")[0]} joined your 5C ride!")
  end
  
  def new_comment_email(commenter, user, url)
    @commenter = commenter
    @url = url
    @user = user
    @email = user.email
    @host = "localhost:3000"
    mail(:to => @email, :subject => "#{user.name.split(" ")[0]} commented on your 5C ride!")
  end
end
