class AddGroupNumberToHacks < ActiveRecord::Migration
  def change
    add_column :hacks, :group_number, :integer
  end
end
