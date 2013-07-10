class AddMcToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mc, :boolean
  end
end
