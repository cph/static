class DropStats < ActiveRecord::Migration
  def up
    drop_table :stats
  end
  
  def down
    create_table :stats do |t|
      t.references :user, index: true
      t.references :skill, index: true
      t.integer :level

      t.timestamps
    end
  end
end
