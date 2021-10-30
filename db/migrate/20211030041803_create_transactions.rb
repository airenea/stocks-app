class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :stock_id
      t.integer :number_of_stocks
      t.decimal :price

      t.timestamps
    end
  end
end
