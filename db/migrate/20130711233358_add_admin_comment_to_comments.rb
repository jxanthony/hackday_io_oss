class AddAdminCommentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :admin_comment, :boolean
  end
end
