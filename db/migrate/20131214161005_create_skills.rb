class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
