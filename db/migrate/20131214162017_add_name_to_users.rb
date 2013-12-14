class AddNameToUsers < ActiveRecord::Migration
  def up
    User.delete_all
    add_column :users, :name, :string, null: false
  end
  
  def down
    remove_column :users, :name
  end
end
