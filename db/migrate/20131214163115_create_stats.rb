class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :user, index: true
      t.references :skill, index: true
      t.integer :level

      t.timestamps
    end
  end
end
