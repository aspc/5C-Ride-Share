class UserMailer < ActionMailer::Base
  default :from => "5C Rideshare <rideshareaspc@gmail.com>"
  
  def new_rider_email(user, rider, rideurl)
    @user = user
    @rider = rider
    @url = rideurl
    @email = user.email
    @host = "5crideshare.jessepollak.me"
    mail(:to => @email, :subject => "#{rider.name} joined your 5C ride!")
  end
  
  def new_comment_email(commenter, user, url)
    @commenter = commenter
    @url = url
    @user = user
    @email = user.email
    @host = "5crideshare.jessepollak.me"
    mail(:to => @email, :subject => "#{commenter.name} commented on your 5C ride!")
  end
end
