class CreateUserAssessments < ActiveRecord::Migration
  def change
    create_table :user_assessments do |t|
      t.references :assessment
      t.references :user
      t.timestamp :completed_at
      
      t.index [:assessment_id, :user_id], unique: true
    end
  end
end
