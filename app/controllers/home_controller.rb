class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :get_api, only: [:show, :search]

    def index
      get_api
    end

    def search
        @stock = Stock.new
    end

    def get_api
        @client = IEX::Api::Client.new(
          publishable_token: 'pk_6db25af117ec4985982e066ca3f76546',
          secret_token: 'sk_e47cea0714f44c6ea3803835fe18a08c',
          endpoint: 'https://cloud.iexapis.com/v1'
        )
    end

    def stock_params
        params[:symbol]
    end

    def stock_id
        params[:id]
    end
end
