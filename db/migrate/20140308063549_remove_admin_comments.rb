class RemoveAdminComments < ActiveRecord::Migration
  def up
    drop_table :admin_comments
  end

  def down
    create_table :admin_comments do |t|
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end
end
