class User < ActiveRecord::Base
  
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
         # :confirmable,
         # :lockable,
         # :timeoutable,
         # :omniauthable
  
  has_many :stats
  
  validates :name, presence: true
  
  after_create :associate_with_default_skills
  
private
  
  def associate_with_default_skills
    stats << Skill.default_for(self).map { |skill| Stat.new(skill: skill) }
  end
  
end
