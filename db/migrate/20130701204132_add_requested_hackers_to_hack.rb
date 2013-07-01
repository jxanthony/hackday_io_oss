class AddRequestedHackersToHack < ActiveRecord::Migration
  def change
    add_column :hacks, :requested_hackers, :integer
  end
end
