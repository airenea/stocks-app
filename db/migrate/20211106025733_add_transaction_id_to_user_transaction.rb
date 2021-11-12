class AddTransactionIdToUserTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :user_transactions, :transaction_id, :integer
  end
end
