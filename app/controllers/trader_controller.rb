class TraderController < ApplicationController
    def index
        @user = current_user
        @owned_stocks = @user.owned_stocks.all
        @stock = Stock.all
    end
end
