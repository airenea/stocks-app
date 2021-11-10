class AllTransactionsController < ApplicationController
    def index
        @user = current_user
        @list_transactions = Transaction.all
        @stock = Stock
        @user = User.all
    end
end
