class BidsController < ApplicationController
    def index
        @bids = Bid.all  
      end
    
      def show
        @bid = Bid.find(bid_id)
        @stock = Stock.where(id:@bid.stock_id)
        @list_bids = Bid.where(stock_id:@bid.stock_id)
        @ask = Ask.all
        @transaction = Transaction.new

      end
     
      def create
        @bid = Bid.new(bid_params)
    
        if @bid.save
          redirect_to bids_show_path(@bid)
        else
        end
      end
    
      private
        def bid_params
          params.require(:bid).permit(:user_id, :stock_id, :number_of_stocks, :price, :bought)
        end
        
        def bid_id
          params[:id]
        end    

        def transaction_params
          params[:id]
        end
end