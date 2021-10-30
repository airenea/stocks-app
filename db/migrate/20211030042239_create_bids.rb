class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.references :user_id, null: false, foreign_key: true
      t.integer :stock_id
      t.integer :number_of_stocks
      t.decimal :price
      t.boolean :bought

      t.timestamps
    end
  end
end
