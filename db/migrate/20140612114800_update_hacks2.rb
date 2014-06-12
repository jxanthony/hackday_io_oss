class UpdateHacks2 < ActiveRecord::Migration
  def change
    add_column :hacks, :video_start, :string
    add_column :hacks, :video_end, :string
  end
end
