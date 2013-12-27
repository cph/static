class Assessment < ActiveRecord::Base
  
  has_many :scores
  
  def self.current
    first # for now there's only one
  end
  
  def results(of: nil, by: nil)
    user, scorer = of, by
    scores.for(user).group_by(&:skill).map do |skill, scores|
      my_score = scores.detect { |score| score.scorer_id == scorer.id }
      Stat.new(skill, scores.average(&:value), my_score.try(:value))
    end
  end
  
  def complete?(by: nil, of: nil)
    return true if completed_at.present?
    return false if of.nil?
    user, scorer = of, by
    
    scores = self.scores.for(user)
    if scorer
      # The given teammate has given this user
      # a score for each of his/her skills
      user.skills.count == scores.by(scorer).count
    else
      # Every teammate has given this user
      # a score for each of his/her skills
      user.skills.count * user.teammates.count == scores.count
    end
  end
  
  def check_if_completed!
    return if completed_at.present?
    
    if User.all.all? { |user| complete?(of: user) }
      update_column :completed_at, Time.now
    end
  end
  
end
