class MakeCommentsPublicByDefault < ActiveRecord::Migration
  def change
    change_column :comments, :private, :boolean, default: false
  end
end
