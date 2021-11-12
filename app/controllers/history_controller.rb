class HistoryController < ApplicationController
    def index
        @user = current_user
        @transaction_history = UserTransaction.where(user_id: @user.id)
        @stock = Stock.all
    end
end
