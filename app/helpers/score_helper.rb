module ScoreHelper
  
  def score_for(user, skill)
    score = @scores.detect do |score|
      score.user_id == user.id && score.skill_id == skill.id
    end
    score ? score.value : 0
  end
  
  def pass_for?(user, skill)
    score = @scores.detect do |score|
      score.user_id == user.id && score.skill_id == skill.id
    end
    score ? score.pass? : false
  end
  
  def completion(of: nil, by: nil)
    completion = @assessment.completion(of: of, by: by)
    unless completion.nil? or completion.nan?
      "<span class=\"stat-completion\">#{number_to_percentage completion, precision: 0}</span>".html_safe
    end
  end
  
  def rank(level)
    level = level.to_int if level.respond_to?(:to_int)
    level = level.to_i
    return "none" if level.nil?
    return "novice" if level < 24
    return "advanced-beginner" if level < 48
    return "competent" if level < 72
    return "proficient" if level < 96
    return "master"
  end
  
end
