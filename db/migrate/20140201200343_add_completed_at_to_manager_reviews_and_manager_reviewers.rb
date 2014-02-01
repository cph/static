class AddCompletedAtToManagerReviewsAndManagerReviewers < ActiveRecord::Migration
  def change
    add_column :manager_reviews, :completed_at, :timestamp
    add_column :manager_reviewers, :completed_at, :timestamp
  end
end
