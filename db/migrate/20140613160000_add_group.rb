class AddGroup < ActiveRecord::Migration
  def change
    add_column :hackdays, :group_id, :integer
  end
end
