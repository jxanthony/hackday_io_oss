class AddVotesToHacks < ActiveRecord::Migration

  def change
    add_column :hacks, :votes, :int
  end

end
