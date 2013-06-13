class ChangeUidType < ActiveRecord::Migration
  def up
  	remove_column :users, :uid
  	add_column :users, :uid, :integer
  end

  def down
  end
end
