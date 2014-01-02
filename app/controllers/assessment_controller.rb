class AssessmentController < ApplicationController
  before_filter :get_assessment
  
  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_url, alert: $!.message
  end
  
  def edit
    redirect_to root_url, notice: "You have already completed this assessment" if assessment.completed?
    
    @users = assessment.subjects
    @skills = assessment.skills
    @scores = assessment.scores
    @assessment = assessment.assessment
  end
  
  def show
    @user = User.find(params[:user_id])
    @skills = assessment.skills
    @scores = assessment.scores
    @assessment = assessment.assessment
  end
  
  def update
    redirect_to root_url, notice: "You have already completed this assessment" if assessment.completed?
    
    ScoreUpdater.new(assessment, params).save!
    
    if request.xhr?
      head :ok
    else
      assessment.completed!
      redirect_to root_url, notice: "Assessment completed!"
    end
  end
  
private
  
  attr_reader :assessment
  
  def scorer
    current_user
  end
  
  def get_assessment
    @assessment = current_user.user_assessments.find_by_assessment_id!(params[:assessment_id])
  end
  
end
