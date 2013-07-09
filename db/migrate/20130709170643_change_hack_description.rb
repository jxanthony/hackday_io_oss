class ChangeHackDescription < ActiveRecord::Migration
  def up
    change_column :hacks, :description, :text
  end

  def down
    change_column :hacks, :description, :string
  end
end
