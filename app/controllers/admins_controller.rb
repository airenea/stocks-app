class AdminsController < ApplicationController
    before_action :set_admin, only: %i[ show edit update destroy ]

  # GET /admins or /admins.json
  def index
    @admins = Admin
  end

  # GET /admins/1 or /admins/1.json
  def show
    @admins = Admin
  end

  # GET /admins/new
  def new
    @admin = Admin
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to @admin
    else
      render :new
    end
  end

  # GET /admins/1/edit
  def edit

  end

  # PATCH/PUT /admins/1 or /admins/1.json
  def update
      if @admin.update(admin_params)
        redirect_to pending_users_path, notice: "Admin was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /admins/1 or /admins/1.json
  def destroy
    @admin.destroy
       redirect_to admins_url, notice: "Admin segular was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:name, :surname, :email, :balance, :approved, :password, :admin)
    end
end