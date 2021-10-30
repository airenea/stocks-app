class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.decimal :current_price
      t.decimal :change
      t.string :percent
      t.decimal :ohlc_close
      t.decimal :ohlc_open
      t.decimal :ohlc_high
      t.decimal :ohlc_low

      t.timestamps
    end
  end
end
