require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  
  context "a new User" do
    setup do
      @user = User.new(
        email: "george.costanza@example.com",
        name: "George Costana",
        password: "password",
        password_confirmation: "password")
    end
    
    should "get associated with all default skills" do
      @user.save!
      assert_equal 12, @user.stats.reload.count
    end
  end
  
  
end
