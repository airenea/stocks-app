class Transaction < ApplicationRecord
    has_many :user_transactions
    accepts_nested_attributes_for :user_transactions, allow_destroy: true
    validates :buyer_id, presence:true     
    validates :stock_id, presence:true         
    validates :number_of_stocks, numericality: { other_than: 0 } 
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
