class ScoresController < ApplicationController
  before_filter :get_assessment, :get_user

  def edit
    @scores = @assessment.scores.by(current_user).for(user).to_a
  end

  def update
    @scores = params.fetch(:skills, {}).map do |skill_id, value|
      Score.find_or_initialize_by(
        scorer_id: current_user.id,
        assessment_id: assessment.id,
        user_id: user.id,
        skill_id: skill_id ).tap do |score|
        score.value = value.to_i
      end
    end
    
    Score.transaction do
      @scores.each(&:save!)
    end
    
    redirect_to root_url, notice: "Your assessment has been saved"
  rescue
    @scores = @assessment.scores.by(current_user).to_a
    flash[:error] = "An error occurred: #{$!.message}"
    render action: "edit"
  end

  attr_reader :assessment, :user
  helper_method :assessment, :user

private

  def get_assessment
    @assessment = Assessment.find(params[:assessment_id])
  end

  def get_user
    @user = User.find(params[:user_id])
  end

end
