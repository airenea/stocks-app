class CreateOwnedStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :owned_stocks do |t|
      t.integer :stock_id
      t.integer :number_of_stocks
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
