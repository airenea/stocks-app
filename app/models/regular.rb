class Regular < User
    validates :name, presence:true     
    validates :email, presence:true         
    validates :surname, presence:true       
    validates :balance, numericality: { greater_than_or_equal_to: 0 }
end