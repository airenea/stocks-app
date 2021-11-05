class AsksController < ApplicationController
  def index
    @asks = Ask.all  
  end

  def show
    @ask = Ask.find(ask_id)
    @stock = Stock.where(id:@ask.stock_id)
    @list_asks = Ask.where(stock_id:@ask.stock_id)
  end

  def create
    @ask = Ask.new(ask_params)

    if @ask.save
      redirect_to asks_show_path(@ask)
    else
    end
  end

  private
    def ask_params
      params.require(:ask).permit(:user_id, :stock_id, :number_of_stocks, :price, :sold)
    end
    
    def ask_id
      params[:id]
    end

end
