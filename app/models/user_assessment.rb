# This model represents the completion of an Assessment
# by an individual User. When an Assessment is created,
# one of these models is created for each user who is
# asked to complete the assessment.
class UserAssessment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :assessment
  
  def self.by(user)
    where(user_id: user.id)
  end
  
  def self.completed
    where(arel_table[:completed_at].not_eq(nil))
  end
  
  delegate :subjects, :skills, to: :assessment
  
  alias :scorer :user
  alias :assessor :user
  
  def completed?
    completed_at.present?
  end
  
  def completed!
    update_column :completed_at, Time.now
  end
  
  # I don't love this word because I have
  # `completed` to say whether the whole
  # assessment was finished; but this is
  # a measure of how many scores were not
  # skipped.
  def completion(of: nil)
    scores = self.scores
    scores = scores.for(of) if of
    passes = scores.where(pass: true).count
    100.0 * (1.0 - passes.to_f / scores.count)
  end
  
  def scores
    @scores ||= assessment.scores.by(user)
  end
  
end
