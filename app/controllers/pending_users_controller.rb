class PendingUsersController < ApplicationController
    def index
        if verify_type()  
            @user = current_user
            @list_traders = Regular.where(approved: false)
            @list_admins = Admin.where(approved: false)
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
