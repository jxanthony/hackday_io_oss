class CreateGlobalConfigurations < ActiveRecord::Migration
  def change
    create_table :global_configurations do |t|
      t.boolean :presentation_in_progress

      t.timestamps
    end
  end
end
