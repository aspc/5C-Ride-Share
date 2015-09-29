require 'spec_helper'

describe RidesController do
  describe "new" do
    it "should render the new template" do
      get :new
      should respond_to('new')
    end
  end
end