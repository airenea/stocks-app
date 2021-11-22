class UserTransaction < ApplicationRecord
    validates :user_id, presence:true     
    validates :stock_id, presence:true         
    validates :number_of_stocks, numericality: { other_than: 0 } 
    validates :price, numericality: { greater_than_or_equal_to: 0 }
end
