class CreateHackdays < ActiveRecord::Migration
  def change
    create_table :hackdays do |t|
      t.string :title
      t.date :date

      t.timestamps
    end
  end
end
