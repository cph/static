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
  has_many :user_assessments
  
  validates :name, presence: true
  
  default_scope order("last_name ASC")
  
  def self.except(user_or_id)
    id = user_or_id.is_a?(User) ? user_or_id.id : user_or_id
    where(arel_table[:id].not_eq(id))
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def skills
    Skill.all # differentiate later
  end
  
  def teammates
    User.except(self)
  end
  
  def score!(user, skill, value, assessment)
    Score.create!(
      scorer: self,
      user: user,
      skill: skill,
      value: value,
      assessment: assessment)
  end
  
end
