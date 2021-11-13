class User < ApplicationRecord
  has_many :bids, dependent: :destroy
  has_many :asks, dependent: :destroy
  has_many :owned_stocks, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  def admin?
    type == 'admin'
    approved == true
  end
  def regular?
    type == 'regular'
  end
end
