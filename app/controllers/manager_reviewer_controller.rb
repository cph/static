class ManagerReviewerController < ApplicationController
  before_filter :find_manager_reviewer!
  
  attr_reader :reviewer
  
  
  def new
    return render :completed if reviewer.completed?
    
    @manager = reviewer.manager
  end
  
  
  def create
    return redirect_to review_manager_path(token: reviewer.token) if reviewer.completed?
    
    reviewer.complete!(review_params)
    redirect_to review_manager_path(reviewer)
  end
  
  
private
  
  def find_manager_reviewer!
    @reviewer = ManagerReviewer.find_by_token!(params[:token])
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public/404.html"), layout: false
  end
  
  def review_params
    params
  end
  
end
