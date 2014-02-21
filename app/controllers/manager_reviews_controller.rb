class ManagerReviewsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]
  
  def index
    @manager_reviews = ManagerReview.for(current_user)
  end
  
  def new
    @review = ManagerReview.new(manager: current_user)
  end
  
  def create
    @review = ManagerReview.new(new_review_params)
    if @review.save
      redirect_to manager_reviews_path, notice: "Invitations sent!"
    else
      render :new
    end
  end
  
  def show
    @review = ManagerReview.find params[:id]
    @manager = @review.manager
  end
  
private
  
  def new_review_params
    params.require(:manager_review).permit(:reviewer_emails).merge(manager: current_user)
  end
  
end
