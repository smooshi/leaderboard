require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context "JSON" do
    it "shoulder get json" do


    end
    it "should create new user" do
      json = { :format => 'json', :name => "foo", :score => 999}
      post :create, json
      User.count.should == 1
    end
  end
end
