class AddDisableDownvoteToHackday < ActiveRecord::Migration
  def change
    add_column :hackdays, :disable_downvote, :boolean, default: false
  end
end
