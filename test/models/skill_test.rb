require "test_helper"

class SkillTest < ActiveSupport::TestCase
  
  
  context "#default_for" do
    should "return all skills for now" do
      user = User.new
      assert_equal 12, Skill.default_for(user).count
    end
  end
  
  
end
