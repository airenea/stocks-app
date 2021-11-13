class AdminsController < ApplicationController
    before_action :set_regular, only: %i[ show edit update destroy ]

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
    @admin = Admin.new(regular_params)
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
      if @admin.update(regular_params)
        redirect_to pending_users_path, notice: "Admin was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /admins/1 or /admins/1.json
  def destroy
    @admin.destroy
       redirect_to admins_url, notice: "Re1 segular was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regular
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def regular_params
      params.require(:regular).permit(:name, :surname, :email, :balance, :approved, :password)
    end
end