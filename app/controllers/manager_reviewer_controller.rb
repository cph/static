class ManagerReviewerController < ApplicationController
  before_filter :find_manager_reviewer!
  
  attr_reader :reviewer
  
  
  def new
    @manager = reviewer.manager
  end
  
  
private
  
  def find_manager_reviewer!
    @reviewer = ManagerReviewer.find_by_token!(params[:token])
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public/404.html"), layout: false
  end
  
end
