class ManagerReviewer < ActiveRecord::Base
  
  belongs_to :review, class_name: "ManagerReview", foreign_key: "manager_review_id"
  
  validate :email_address_must_be_plausible
  validates :token, presence: true, uniqueness: true
  
  before_validation :assign_token, on: :create
  after_create :invite_reviewer!
  
  delegate :manager, to: :review
  
  
  def invite_reviewer!
    ManagerReviewMailer.reviewer_invitation(self).deliver!
  end
  
  
private
  
  def email_address_must_be_plausible
    address = Mail::Address.new(email_address)
    unless address.domain && address.address == email_address
      errors.add :base, "#{email_address.inspect} is not a valid email address"
    end
  end
  
  def assign_token
    self.token = SecureRandom.uuid.gsub("-", "")
  end
  
end
