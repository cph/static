class Stat < Struct.new(:skill, :level)
  
  delegate :name, :category, :description, to: :skill
  
  def complete?
    level.present?
  end
  
  def rank
    return "none" unless complete?
    return "novice" if level < 24
    return "advanced-beginner" if level < 48
    return "competent" if level < 72
    return "proficient" if level < 96
    return "master"
  end
  
end
