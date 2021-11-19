class StocksController < ApplicationController
    before_action :get_api, only: [:create, :search, :show]
    
    def search
        @stock = Stock.new
    end

    def create
        begin
            @stock = Stock.find_or_create_by(symbol: params[:symbol], name: @client.company(stock_params).company_name)
            @quote = @client.quote(stock_params)
            
            @stock.current_price = @quote.latest_price
            @stock.symbol = @quote.symbol

            if @stock.save
                redirect_to stocks_show_path(@stock)
            else
            end
        rescue IEX::Errors::SymbolNotFoundError => e
            flash[:alert] = e.message # "Stock symbol not valid"
            redirect_to stocks_search_path
        end
    end

    def show
        @stock = Stock.find(stock_id)
        @ask = Ask.new(ask_params)
        @bid = Bid.new(bid_params)
        @list_bids = Bid.where(stock_id: stock_id).where(bought: false).where.not(user_id: current_user.id)
        @list_asks = Ask.where(stock_id: stock_id).where(sold: false).where.not(user_id: current_user.id)

    end

    def get_api
        @client = IEX::Api::Client.new(
          publishable_token: Rails.application.credentials.iex_publishable_token,
          secret_token: Rails.application.credentials.iex_secret_token,
          endpoint: 'https://cloud.iexapis.com/v1'
        )
    end

    def asks
        @ask = Ask.all
    end

    def stock_params
        params[:symbol]
    end

    def ask_params
        params[:stock_id]
    end

    def bid_params
        params[:stock_id]
    end

    def stock_id
        params[:id]
    end
end
