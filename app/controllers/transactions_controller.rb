class TransactionsController < ApplicationController
    def index
        @transactions = Transaction.all  
      end
    
      def new
        @transaction = Transaction.new
        @transaction.user_transactions.build
      end

      def show
        @transaction = Transaction.find(transaction_id)
        @seller = User.find(@transaction.seller_id)
        @buyer = User.find(@transaction.buyer_id)
        # ADJUST BALANCES
        change_balance = @transaction.price * @transaction.number_of_stocks
        buyer_balance = current_user.balance - change_balance
        seller_balance = @seller.balance + change_balance
        @buyer.update(balance: buyer_balance)
        @seller.update(balance: seller_balance)
        
        # ADJUST STOCKS (BUYER)
        buyer_stock = @buyer.owned_stocks.find_or_create_by(stock_id: @transaction.stock_id)
        buyer_updated_stocks = buyer_stock.number_of_stocks + @transaction.number_of_stocks
        buyer_stock.update(number_of_stocks: buyer_updated_stocks)

        # ADJUST STOCKS (SELLER)
        seller_stock = @seller.owned_stocks.find_or_create_by(stock_id: @transaction.stock_id)
        seller_updated_stocks = seller_stock.number_of_stocks - @transaction.number_of_stocks
        seller_stock.update(number_of_stocks: seller_updated_stocks)
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
