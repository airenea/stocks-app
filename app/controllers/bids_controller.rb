class BidsController < ApplicationController

    def index
        @bids = Bid.all  
    end
    
      def show
        @bid = Bid.find(bid_id)
        @stock = Stock.where(id:@bid.stock_id)
        @ask = Ask.all
        @list_asks = Ask.where(stock_id:@bid.stock_id).where(sold: false).where.not(user_id: current_user.id)
        @list_bids = Bid.where(stock_id:@bid.stock_id).where(bought: false).where.not(user_id: current_user.id)
        @transaction = Transaction.new
        @transaction.user_transactions.build
      end
     
      def create
        @bid = Bid.new(bid_params)
        @user = current_user
        @stock_url = '/stocks/show/' + @bid.stock_id.to_s

        total_price = @bid.number_of_stocks * @bid.price
        if total_price < @user.balance
          @bid.save
          if @bid.save
            redirect_to bids_show_path(@bid)
          end
        else
          redirect_to @stock_url, notice: 'Insufficient balance, please add more cash'
        end
      end
    
      private
        def bid_params
          params.require(:bid).permit(:user_id, :stock_id, :number_of_stocks, :price, :bought, :total_price)
        end
        
        def bid_id
          params[:id]
        end    

        def transaction_params
          params[:id]
        end
      
end