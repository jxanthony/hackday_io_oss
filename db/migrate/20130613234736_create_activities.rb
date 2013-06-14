class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :hack_id
      t.string :action

      t.timestamps
    end
  end
end
