class CreateUserTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_transactions do |t|
      t.integer :user_id
      t.integer :stock_id
      t.integer :number_of_stocks
      t.decimal :price
      t.timestamps
    end
  end
end
