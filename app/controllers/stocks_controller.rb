class StocksController < ApplicationController
    before_action :get_api, only: [:create, :search]
    
    def search
        @stock = Stock.new
    end

    def create
        @stock = Stock.find_or_create_by(symbol: params[:symbol], name: @client.company(stock_params).company_name)
        @quote = @client.quote(stock_params)
        
        @stock.current_price = @quote.latest_price
        @stock.symbol = @quote.symbol

        if @stock.save
            redirect_to stocks_show_path(@stock)
        else
        end
    end

    def show
        @stock = Stock.find(stock_id)
        @ask = Ask.new(ask_params)
        @bid = Bid.new(bid_params)
    end

    def get_api
        @client = IEX::Api::Client.new(
          publishable_token: 'pk_6db25af117ec4985982e066ca3f76546',
          secret_token: 'sk_e47cea0714f44c6ea3803835fe18a08c',
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
