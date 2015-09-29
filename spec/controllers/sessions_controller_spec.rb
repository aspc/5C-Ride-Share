require 'spec_helper'

OmniAuth.config.test_mode = true

 describe SessionsController do
   describe "#login" do
     it "should redirect user to /auth/facebook" do
       get 'login'
       should redirect_to '/auth/facebook'
     end
     it "should store request.env['HTTP_REFERER'] in session[:redirect_to] if it exists" do
       request.env['HTTP_REFERER'] = "http://www.example.com"
       get 'login'
       session[:redirect_to].should equal(request.env['HTTP_REFERER'])
     end
     it "should not store request.env['HTTP_REFERER'] in session[:redirect_to] if it does not exist" do
       get 'login'
       session[:redirect_to].should == nil
     end
   end
 end