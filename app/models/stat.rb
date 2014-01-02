class Stat < Struct.new(:skill, :level, :my_level)
  
  delegate :name, :category, :description, to: :skill
  
  def completed?
    level.present?
  end
  
  def to_int
    level
  end
  
end
