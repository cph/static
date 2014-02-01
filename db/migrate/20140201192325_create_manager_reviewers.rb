class CreateManagerReviewers < ActiveRecord::Migration
  def change
    create_table :manager_reviewers do |t|
      t.references :manager_review, null: false
      t.string :email_address, null: false
      t.string :token, null: false
      t.timestamps
    end
  end
end
