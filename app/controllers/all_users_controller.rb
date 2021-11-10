class AllUsersController < ApplicationController
    def index
        @user = current_user
        @list_traders = Regular.all
        @list_admins = Admin.all
    end
end
