class UserMailer < ActionMailer::Base
  default :from => "5C Ride Share <5crideshare@gmail.com>"
  
  def new_rider_email(user, rider, rideurl)
    @user = user
    @rider = rider
    @url = rideurl
    mail(:to => user.email, :subject => "#{rider.name} joined your 5C ride!")
  end
end
