class Score < ActiveRecord::Base
  
  belongs_to :scorer, class_name: "User"
  belongs_to :user
  belongs_to :assessment
  belongs_to :skill
  
  validates :user, :skill, :scorer, :assessment, presence: true
  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :skill, uniqueness: { scope: [:user_id, :scorer_id, :assessment_id] }
  
  def self.for(user)
    where(user_id: user.id)
  end
  
  def self.by(scorer)
    where(scorer_id: scorer.id)
  end
  
end
