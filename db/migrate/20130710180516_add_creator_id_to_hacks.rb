class AddCreatorIdToHacks < ActiveRecord::Migration
  def change
    add_column :hacks, :creator_id, :integer
  end
end
