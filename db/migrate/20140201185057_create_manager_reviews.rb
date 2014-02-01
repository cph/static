class CreateManagerReviews < ActiveRecord::Migration
  def change
    create_table :manager_reviews do |t|
      t.references :manager, null: false
      t.timestamps
    end
  end
end
