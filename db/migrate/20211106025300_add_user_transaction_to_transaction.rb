class AddUserTransactionToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :user_transaction, :string
  end
end
