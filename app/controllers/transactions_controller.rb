class TransactionsController < ApplicationController
    def index
        @transactions = Transaction.all  
      end
    
      def show
        @transaction = Transaction.find(transaction_id)
        @stock = Stock.where(id:@transaction.stock_id)
        @list_transactions = Transaction.where(stock_id:@transaction.stock_id)
        @ask = Ask.all
      end
     
      def create
        @transaction = Transaction.new(transaction_params)
    
        if @transaction.save
          redirect_to transactions_show_path(@transaction)
        else
        end
      end
    
      private
        def transaction_params
          params.require(:transaction).permit(:user_id, :stock_id, :number_of_stocks, :price, :bought)
        end
        
        def transaction_id
          params[:id]
        end
end
