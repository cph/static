class Assessment < ActiveRecord::Base
  
  has_many :scores, dependent: :destroy
  has_many :user_assessments, dependent: :destroy
  
  after_create :create_user_assessments
  
  validates :assessors, length: {minimum: 1, message: "You must have at least one assessor"}
  
  def self.current
    first # for now there's only one
  end
  
  
  
  def subjects
    User.all # for now, everyone
  end
  
  def skills
    Skill.all # for now, all skills
  end
  
  def assessors
    return @assessors if defined?(@assessors) or new_record?
    @assessors = User.joins(:user_assessments).merge(user_assessments)
  end
  
  attr_writer :assessors
  
  
  
  def completion(of: nil, by: nil)
    if by
      assessment = user_assessments.by(by).first
      return 0.0/0 if assessment.nil? or !assessment.completed?
      assessment.completion(of: of)
    else
      user_assessments.completed.to_a.average { |assessment| assessment.completion(of: of) }
    end
  end
  
  def results(of: nil, by: nil, only_by: nil)
    user, scorer = of, only_by || by
    scores.for(user).reject { |score| score.skill.nil? }.group_by(&:skill).map do |skill, scores|
      my_score = scores.detect { |score| score.scorer_id == scorer.id }
      my_score = my_score && !my_score.pass? ? my_score.value : 0
      group_score = scores.reject(&:pass?).average(&:value) unless only_by
      Stat.new(skill, group_score, my_score)
    end
  end
  
  def completed?(by: nil)
    if by
      assessment = user_assessments.by(by).first
      assessment && assessment.completed?
    else
      user_assessments.all?(&:completed?)
    end
  end
  
  
  
private
  
  def create_user_assessments
    assessors.map do |assessor|
      user_assessments.create(user: assessor)
    end
    
    # reload assessors on-demand so that it is an assocation not an Array
    remove_instance_variable :@assessors
  end
  
end
