class AddUpvotedByToHacks < ActiveRecord::Migration
  def change
    add_column :hacks, :upvoted_by, :text, :default => []
  end
end
