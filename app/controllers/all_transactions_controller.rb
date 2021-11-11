class AllTransactionsController < ApplicationController
    # before_action :verify_type
    def index
        if verify_type()  
            @user = current_user
            @list_transactions = Transaction.all
            @stock = Stock
            @user = User.all
        else
            redirect_to home_index_path, notice: 'ur not an admin'
        end
    end

    private
     def verify_type
        if(current_user.type == "Admin")
            return true
        else
            return false
        end
    end
end
