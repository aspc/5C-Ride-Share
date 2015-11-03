# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Shuttleshare::Application.initialize!


ActionMailer::Base.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 465,
  :user_name => "system@aspc.pomona.edu",
  :password => YAML.load_file("#{Rails.root}/config/email.credentials.yml")['password'],
  :authentication => 'plain',
  :enable_starttls_auto => true
}