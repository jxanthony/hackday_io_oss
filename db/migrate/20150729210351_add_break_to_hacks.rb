class AddBreakToHacks < ActiveRecord::Migration
  def change
    add_column :hacks, :breaktime, :boolean, default: false
  end
end
