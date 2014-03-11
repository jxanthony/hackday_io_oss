class RenameAdminCommentToPrivate < ActiveRecord::Migration
  def change
    rename_column :comments, :admin_comment, :private
  end
end
