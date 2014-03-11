class RenameAdmins < ActiveRecord::Migration
  def change
    rename_table :admins, :hackdays_users
  end
end
