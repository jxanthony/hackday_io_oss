class AddMugshotUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mugshot_url, :string
  end
end
