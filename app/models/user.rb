class User < ApplicationRecord
  has_many :bids
  has_many :asks
  has_many :owned_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def admin?
    type == 'admin'
    approved == true
  end
  def regular?
    type == 'regular'
  end
end
