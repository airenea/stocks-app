class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :get_api, only: [:show, :search, :index]

    def index
    end

    def search
        @stock = Stock.new
    end

    def get_api
      @client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iex_publishable_token,
        secret_token: Rails.application.credentials.iex_secret_token,
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
