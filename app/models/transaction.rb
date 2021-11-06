class Transaction < ApplicationRecord
    has_many :user_transactions
    accepts_nested_attributes_for :user_transactions, allow_destroy: true
end
