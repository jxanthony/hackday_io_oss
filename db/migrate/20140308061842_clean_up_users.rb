class CleanUpUsers < ActiveRecord::Migration
  def up
    remove_column :users, :mc
    remove_column :users, :admin
    remove_column :users, :bankroll
  end

  def down
    add_column :users, :mc, :boolean
    add_column :users, :admin, :boolean
    add_column :users, :admin, :integer
  end
end
