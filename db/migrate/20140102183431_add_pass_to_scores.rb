class AddPassToScores < ActiveRecord::Migration
  def change
    add_column :scores, :pass, :boolean, null: false, default: false
  end
end
