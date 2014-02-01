class ManagerReviewMailer < ActionMailer::Base
  
  attr_reader :token, :manager
  
  
  def reviewer_invitation(reviewer)
    @token = reviewer.token
    @manager = reviewer.manager
    mail(
      to: reviewer.email_address,
      subject: "Please complete your review of #{manager.name}"
    )
  end
  
  
end
