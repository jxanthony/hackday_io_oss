class AddBankrollToUser < ActiveRecord::Migration

  def change
    add_column :users, :bankroll, :int, :default => 10
  end

end
