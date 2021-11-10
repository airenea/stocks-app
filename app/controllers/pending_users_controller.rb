class PendingUsersController < ApplicationController
    def index
        @user = current_user
        @list_traders = Regular.where(approved: false)
        @list_admins = Admin.where(approved: false)
    end
end
