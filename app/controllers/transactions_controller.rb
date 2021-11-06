class TransactionsController < ApplicationController
    def index
        @transactions = Transaction.all  
      end
    
      def new
        @transaction = Transaction.new
        2.times { @transaction.user_transactions.build }
      end

      def show
        @transaction = Transaction.find(transaction_id)
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
          params.require(:transaction).permit(:buyer_id, :seller_id, :stock_id, :number_of_stocks, :price, user_transactions_attributes: [:user_id, :stock_id, :number_of_stocks, :price])
        end
        
        def transaction_id
          params[:id]
        end
end
