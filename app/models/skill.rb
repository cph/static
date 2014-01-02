class Skill < ActiveRecord::Base
  
  validates :name, :description, :category, presence: true
  
  default_scope order(<<-SQL)
    CASE category
      WHEN 'Language' THEN 1
      WHEN 'Tool' THEN 2
      WHEN 'Framework' THEN 3
      WHEN 'Technique' THEN 4
    END, created_at ASC
  SQL
  
  def self.default_for(user)
    all
  end
  
  def abilities(ability)
    raise ArgumentError.new("") unless %w{novice advanced_beginner competent proficient master}.member?(ability)
    send(:"#{ability}_abilities") || []
  end
  
end
