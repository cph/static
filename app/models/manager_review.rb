class ManagerReview < ActiveRecord::Base
  
  belongs_to :manager
  has_many :reviewers, class_name: "ManagerReviewer", validate: false, autosave: true
  
  validate :reviewers_must_be_valid
  
  
  def self.for(manager)
    where(manager_id: manager.id)
  end
  
  
  attr_reader :reviewer_emails
  def reviewer_emails=(value)
    @reviewer_emails = value.to_s
    
    reviewers.clear
    reviewer_emails.split.map(&:strip).reject(&:blank?).each do |email_address|
      reviewers.build(email_address: email_address, review: self)
    end
  end
  
  
  def date
    created_at.to_date if created_at
  end
  
  
private
  
  def reviewers_must_be_valid
    if reviewers.empty?
      errors.add :base, "You must have at least one reviewer"
    else
      reviewers.each do |reviewer|
        errors.add :base, "#{reviewer.email_address.inspect} is not a valid email address" unless reviewer.valid?
      end
    end
  end
  
end
