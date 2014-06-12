class UpdateHacks2 < ActiveRecord::Migration
  def change
    remove_column :hacks, :time_index, :time_index
    add_column :hacks, :video_start, :string
    add_column :hacks, :video_end, :string
  end
end
