class AllUsersController < ApplicationController
    def index
        if verify_type()  
            @user = current_user
            @list_users = User.all
            @list_traders = Regular.all
            @list_admins = Admin.all
        else
            redirect_to home_index_path, notice: 'ur not an admin'
        end
    end

    private
        def verify_type
            if(current_user.type == "Admin")
                return true
            else
                return false
            end
        end
end
