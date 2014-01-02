require "test_helper"

class AssessmentTest < ActiveSupport::TestCase
  
  attr_reader :assessment
  
  
  context "#new" do
    should "require at least one assessor" do
      assessment = Assessment.new
      refute assessment.valid?, "An assessment without assessors should be invalid"
      assert_match /must have at least one assessor/, assessment.errors.full_messages.join("\n")
    end
    
    should "create a UserAssessment for each assessor" do
      user = User.create!(email: "test@example.com", first_name: "Test", last_name: "User", password: "password", password_confirmation: "password")
      assessment = Assessment.create!(assessors: [user])
      assert UserAssessment.where(user_id: user.id, assessment_id: assessment.id).first,
        "A UserAssessment for the user and assessment was not created"
    end
  end
  
  
  context "#assessors" do
    setup do
      user = User.create!(email: "test@example.com", first_name: "Test", last_name: "User", password: "password", password_confirmation: "password")
      @assessment = Assessment.create!(assessors: [user])
    end
    
    should "return a relation that represents the user who are performing this assessment" do
      assert assessment.assessors.is_a?(ActiveRecord::Relation), "assessment#assessors is not an ActiveRecord::Relation"
      assert_equal [User], assessment.assessors.map(&:class)
    end
  end
  
  
end
