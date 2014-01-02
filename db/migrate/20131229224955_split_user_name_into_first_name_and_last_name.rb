class SplitUserNameIntoFirstNameAndLastName < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    
    User.reset_column_information
    User.find_each do |user|
      first_name, last_name = user.read_attribute(:name).split(" ")
      user.update_attributes!(first_name: first_name, last_name: last_name)
    end
    
    remove_column :users, :name
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
  end
  
  def down
    add_column :users, :name, :string
    
    User.reset_column_information
    User.find_each do |user|
      user.update_attributes!(name: "#{user.first_name} #{user.last_name}")
    end
    
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
