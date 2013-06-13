class CreateHacks < ActiveRecord::Migration
  def change
    create_table :hacks do |t|
      t.string :title
      t.string :description
      t.integer :score

      t.timestamps
    end
  end
end
