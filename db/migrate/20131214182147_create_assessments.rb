class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
