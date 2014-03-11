class MoveGlobalConfigToHackday < ActiveRecord::Migration
  def up
    add_column :hackdays, :presentation_in_progress, :boolean
    add_column :hackdays, :group_numbers, :text

    remove_column :global_configurations, :presentation_in_progress
    remove_column :global_configurations, :group_numbers
  end

  def down
    remove_column :hackdays, :presentation_in_progress
    remove_column :hackdays, :group_numbers

    add_column :global_configurations, :presentation_in_progress, :boolean
    add_column :global_configurations, :group_numbers, :text
  end
end
