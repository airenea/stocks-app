class AddTotalPriceToBids < ActiveRecord::Migration[6.1]
  def change
    add_column :bids, :total_price, :decimal
  end
end
