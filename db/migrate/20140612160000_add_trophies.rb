class AddTrophies < ActiveRecord::Migration
  def change
    add_column :hackdays, :trophy_name, :string
    add_column :hackdays, :trophy_icon, :string
  end
end
