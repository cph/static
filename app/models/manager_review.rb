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
  
  
  def completed?
    completed_at.present?
  end
  
  
  def completed!
    touch(:completed_at) if reviewers.all?(&:completed?)
  end
  
  
  def sections
    @sections ||= begin
      pronoun = manager.pronoun.capitalize
      MANAGER_REVIEW.map do |predicate, questions|
        Section.new(predicate, questions.map { |question| "#{pronoun} #{question}"})
      end
    end
  end
  
  def results_for(question)
    id = question.hash.to_s
    reviewers.map { |reviewer| reviewer.results[id].to_i }.avg
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


MANAGER_REVIEW = {
  "is a good coach" => [
    "gives me actionable feedback that helps me improve my performance.",
    "helps me understand how my performance is evaluated.",
    "regularly gives me positive feedback for things I did well.",
    "is quick to grant credit to team members for their work.",
    "delivers difficult feedback constructively and encourages me to learn from my mistakes."
  ],

  "empowers the team and does not micromanage" => [
    "does not \"micro-manage\" (get involved in details that should be handled at other levels).",
    "helps me navigate barriers and roadblocks (e.g., insufficient resources, conflicting priorities) that prevent me from working effectively.",
    "develops a spirit of teamwork and encourages initiative, involvement, and innovation in the team."
  ],

  "expresses interest/concern for team members' success and personal well-being" => [
    "shows consideration for me as a person.",
    "encourages maintaining a balance between work and personal life.",
    "recognizes high performance and expresses his/her appreciation for it in a timely manner."
  ],

  "is productive and results-oriented" => [
    "keeps the team focused on priority results/deliverables.",
    "helps me establish priorities for work to be done.",
    "plans and conducts effective meetings."
  ],

  "is a good communicator" => [
    "regularly shares relevant information from his/her manager and senior leadership.",
    "makes time to listen to me, including regular 1 on 1s.",
    "is receptive to suggestions for changing or improving the way work is accomplished."
  ],

  "helps with career development" => [
    "has had a meaningful discussion with me about my career in the past six months.",
    "helps me identify opportunities (e.g., projects, learning programs) to develop my skills and career.",
    "talks about all aspects of career development-not just promotions."
  ],

  "has a vision" => [
    "communicates clear goals for the team.",
    "makes decisions that serve the best interests of CPH overall.",
    "helps me understand how my work impacts the organization.",
    "leads by example."
  ],

  "uses technical skills to advise" => [
    "has the technical expertise (i.e., coding, business expertise, accounting, sales) to effectively manage me.",
    "works side-by-side with the team to get things done when needed.",
    "seeks to acquire knowledge of emerging technologies or developments in their field."
  ]
}.freeze
