class Stat < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :skill
  
  validates :user, :skill, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true }
  
  delegate :name, :category, :description, to: :skill
  
  def rank
    return "novice" if level < 24
    return "advanced-beginner" if level < 48
    return "competent" if level < 72
    return "proficient" if level < 96
    return "master"
  end
  
end
