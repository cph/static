class AddShortnameAndAbilitiesToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :shortname, :string
    add_column :skills, :novice_abilities, :string, array: true
    add_column :skills, :advanced_beginner_abilities, :string, array: true
    add_column :skills, :competent_abilities, :string, array: true
    add_column :skills, :proficient_abilities, :string, array: true
    add_column :skills, :master_abilities, :string, array: true
  end
end
