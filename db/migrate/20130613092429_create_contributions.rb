class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :hack_id
      t.integer :user_id

      t.timestamps
    end
  end
end
