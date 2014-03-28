class RemoveCruft < ActiveRecord::Migration
  def up
    remove_column :hacks, :creator_id
    remove_column :hacks, :requested_hackers
    remove_column :hacks, :group_number
    remove_column :hackdays, :group_numbers
    drop_table :global_configurations
  end

  def down
    # THERE IS NO GOING BACK
  end
end
