require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the name set correctly" do
    user = User.new name:"Pekka"

    user.name.should == "Pekka"
  end
end
