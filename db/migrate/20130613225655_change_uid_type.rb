class ChangeUidType < ActiveRecord::Migration
  def up
  	change_column :users, :uid, :integer
  end

  def down
  end
end
