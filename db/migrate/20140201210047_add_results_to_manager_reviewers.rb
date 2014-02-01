class AddResultsToManagerReviewers < ActiveRecord::Migration
  def change
    add_column :manager_reviewers, :results, :text
  end
end
