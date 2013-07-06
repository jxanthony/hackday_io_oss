class AddPresentationIndexToHacks < ActiveRecord::Migration
  def change
    add_column :hacks, :presentation_index, :integer
  end
end
