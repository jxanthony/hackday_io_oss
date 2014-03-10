class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :hackday_id
      t.integer :user_id
    end
  end
end
