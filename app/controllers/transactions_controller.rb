class TransactionsController < ApplicationController
    def index
        @transactions = Transaction.all  
      end
    
      def new
        @transaction = Transaction.new
        @transaction.user_transactions.build
      end

      def adjust_bid_ask
        @transaction = Transaction.find(transaction_id)
        transaction_stocks = @transaction.number_of_stocks
        # ADJUST ASK
        if @ask != nil
          ask_stocks = @ask.number_of_stocks
          ask_stocks_new = ask_stocks
          if ask_stocks > transaction_stocks
            ask_stocks_new = ask_stocks - transaction_stocks
            @ask.update(number_of_stocks: ask_stocks_new)
          elsif ask_stocks == transaction_stocks
            @ask.update(number_of_stocks: 0)
            @ask.update(sold: true)
          end
        else
        end

        # ADJUST BID
        bid_stocks = @bid.number_of_stocks
        bid_stocks_new = bid_stocks
        if bid_stocks > transaction_stocks
          bid_stocks_new = ask_stocks - transaction_stocks
          @bid.update(number_of_stocks: bid_stocks_new)
        else
          @bid.update(number_of_stocks: 0)
          @bid.update(bought: true)
        end
      end

      def show
        @transaction = Transaction.find(transaction_id)
        @seller = User.find_or_create_by(id: @transaction.seller_id)
        @buyer = User.find(@transaction.buyer_id)
        @ask = Ask.where(user_id: @seller.id).where(stock_id: @transaction.stock_id).where(price: @transaction.price).where(sold: false)[0]
        @bid = Bid.where(user_id: @buyer.id).where(stock_id: @transaction.stock_id).where(price: @transaction.price).where(bought: false)[0]

        # ADJUST BALANCES
        change_balance = @transaction.price * @transaction.number_of_stocks
        buyer_balance = current_user.balance - change_balance
        @buyer.update(balance: buyer_balance)
        if @seller.balance != nil
          seller_balance = @seller.balance + change_balance
          @seller.update(balance: seller_balance)
        else
        end
        
        # ADJUST STOCKS (BUYER)
        buyer_stock = @buyer.owned_stocks.find_or_create_by(stock_id: @transaction.stock_id)
        if buyer_stock.number_of_stocks == nil
          buyer_stock.update(number_of_stocks: 0)
        end
        buyer_updated_stocks = buyer_stock.number_of_stocks + @transaction.number_of_stocks
        buyer_stock.update(number_of_stocks: buyer_updated_stocks)

        # ADJUST STOCKS (SELLER)
        if @transaction.seller_id != nil
          seller_stock = @seller.owned_stocks.find_or_create_by(stock_id: @transaction.stock_id)
          if seller_stock.number_of_stocks == nil
            seller_stock.update(number_of_stocks: 0)
          end
          if seller_stock.number_of_stocks != nil
            seller_updated_stocks = seller_stock.number_of_stocks - @transaction.number_of_stocks
            seller_stock.update(number_of_stocks: seller_updated_stocks)
          else
          end
        end

        # ADJUST ASKS/BIDS
        if @bid != nil
          adjust_bid_ask
        end

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
