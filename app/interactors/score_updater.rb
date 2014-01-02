class ScoreUpdater
  
  def initialize(user_assessment, params)
    @user_assessment = user_assessment
    @updates = process_params(params)
  end
  
  attr_reader :user_assessment, :updates
  alias :assessment :user_assessment
  
  delegate :scores, :assessment_id, :scorer, to: :user_assessment
  
  def save!
    updates.each do |update|
      user_id = update[:user_id]
      skill_id = update[:skill_id]
      pass = update[:value] == "pass"
      value = update[:value].to_i
      
      score = scores.detect { |score| score.user_id == user_id && score.skill_id == skill_id }
      score ||= Score.new(
        assessment_id: assessment_id,
        scorer: scorer,
        user_id: user_id,
        skill_id: skill_id)
      score.value = value
      score.pass = pass
      score.save! unless score.changes.empty?
    end
  end
  
  def process_params(params)
    updates = []
    
    params.fetch(:user, {}).each do |user_id, params|
      user_id = user_id.to_i
      params.fetch(:skill, {}).each do |skill_id, value|
        skill_id = skill_id.to_i
        updates << { user_id: user_id, skill_id: skill_id, value: value }
      end
    end
    
    updates
  end
  
end
