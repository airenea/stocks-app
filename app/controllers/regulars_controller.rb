class RegularsController < ApplicationController
    before_action :set_regular, only: %i[ show edit update destroy ]

  # GET /regulars or /regulars.json
  def index
    @regulars = Regular
  end

  # GET /regulars/1 or /regulars/1.json
  def show
    @regulars = Regular
  end

  # GET /regulars/new
  def new
    @regular = Regular
  end

  def create
    @regular = Regular.new(regular_params)
    if @regular.save
      redirect_to @regular
    else
      render :new
    end
  end

  # GET /regulars/1/edit
  def edit

  end

  # PATCH/PUT /regulars/1 or /regulars/1.json
  def update
      if @regular.update(regular_params)
        redirect_to pending_users_path, notice: "Regular was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /regulars/1 or /regulars/1.json
  def destroy
    @regular.destroy
       redirect_to regulars_url, notice: "Re1 segular was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regular
      @regular = Regular.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def regular_params
      params.require(:regular).permit(:name, :surname, :email, :balance, :approved, :password)
    end
end