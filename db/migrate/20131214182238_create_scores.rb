class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :scorer, index: true
      t.references :user, index: true
      t.integer :value, null: false
      t.references :assessment, index: true
      t.references :skill, index: true
      
      t.timestamps
      
      t.index %i{scorer_id user_id assessment_id skill_id}, unique: true, name: "index_scores_on_all_associations"
    end
  end
end
