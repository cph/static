class Skill < ActiveRecord::Base
  
  validates :name, :description, :category, presence: true
  
  def self.default_for(user)
    all
  end
  
end
