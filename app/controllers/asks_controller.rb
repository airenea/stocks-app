class AsksController < ApplicationController
  def index
      @asks = Ask.all  
  end
  
    def show
      @ask = Ask.find(ask_id)
      @stock = Stock.where(id:@ask.stock_id)
      @list_asks = Ask.where(stock_id:@ask.stock_id).where(sold: false).where.not(user_id: current_user.id)
      @list_bids = Bid.where(stock_id:@ask.stock_id).where(bought: false).where.not(user_id: current_user.id)
      @bid = Bid.all
      @transaction = Transaction.new
      @transaction.user_transactions.build
    end
   
    def create
      @ask = Ask.new(ask_params)
  
      if @ask.save
        redirect_to asks_show_path(@ask)
      else
      end
    end

    def edit
      @ask = Ask.find(ask_id)
      @stock = Stock.where(id:@ask.stock_id)
      @bid = Bid.all
      @list_asks = Ask.where(stock_id:@ask.stock_id).where(sold: false).where.not(user_id: current_user.id)
      @list_bids = Bid.where(stock_id:@ask.stock_id).where(bought: false).where.not(user_id: current_user.id)
      @transaction = Transaction.new
      @transaction.user_transactions.build
    end

    # PATCH/PUT /regulars/1 or /regulars/1.json
    def update
      @ask = Ask.find(ask_id)
        if @ask.update(ask_params)
          redirect_to @ask, notice: "Ask was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
    end

  
    private
      def ask_params
        params.require(:ask).permit(:user_id, :stock_id, :number_of_stocks, :price, :sold)
      end
      
      def ask_id
        params[:id]
      end    

      def transaction_params
        params[:id]
      end
    
end