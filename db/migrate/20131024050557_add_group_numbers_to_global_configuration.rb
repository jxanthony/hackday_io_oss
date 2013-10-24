class AddGroupNumbersToGlobalConfiguration < ActiveRecord::Migration
  def change
    add_column :global_configurations, :group_numbers, :text
  end
end
