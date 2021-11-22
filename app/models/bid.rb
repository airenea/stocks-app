class Bid < ApplicationRecord
  belongs_to :user

  validates :number_of_stocks, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
