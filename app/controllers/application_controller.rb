class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  
    before_action :update_allowed_parameters, if: :devise_controller?
    before_action:authenticate_user!
    helper_method :current_user
    protected
    devise_group :user, contains: [:admin, :regular]

    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :admin, :approved, :password, :balance)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :surname, :email, :admin, :approved, :password, :current_password, :balance)}
    end
end
