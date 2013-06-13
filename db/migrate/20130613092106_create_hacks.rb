class CreateHacks < ActiveRecord::Migration
  def change
    create_table :hacks do |t|
      t.string :title
      t.string :description
      t.integer :votes, :default => 0
      t.string :url

      t.timestamps
    end
  end
end
