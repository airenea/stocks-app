class PendingUsersController < ApplicationController
    def index
        @user = current_user
        @list_users = User.where(approved: false)
    end
end
