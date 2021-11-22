class Transaction < ApplicationRecord
    has_many :user_transactions
    accepts_nested_attributes_for :user_transactions, allow_destroy: true

    validates :number_of_stocks, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
