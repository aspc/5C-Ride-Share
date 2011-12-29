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
   
   describe "#create" do
     
     it "should create a new user if one does not exists" 
     it "should find the user it one does exist"
     it "should redirect to session[:redirect_to] if it exists"
     it "should redirect to root_url if session[:redirect_to] does not exist"
   end
   describe "#destroy" do
     it "should set the session[:user_id] to nil"
     it "should redirect to root_url"
   end
   describe "#failure" do
     it "should render the failure view"
   end
   
 end