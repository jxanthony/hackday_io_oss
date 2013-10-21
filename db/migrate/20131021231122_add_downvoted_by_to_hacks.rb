class AddDownvotedByToHacks < ActiveRecord::Migration
  def change
    add_column :hacks, :downvoted_by, :text, :default => []
  end
end
