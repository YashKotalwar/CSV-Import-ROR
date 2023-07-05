class Api::V1::UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy ]

  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
    render json: @users, status: 200
  end

  # GET /users/1 or /users/1.json
  def show
    render json: @users, status: 200
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to user_url(@user), notice: "User was successfully created." }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /users/1 or /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end


  # DELETE /users/1 or /users/1.json
  # def destroy
  #   @user.destroy

  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: "User was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  def destroy
    @user.destroy
    head :no_content
  end

  # import method
  # request.referer to track the users navigation flow
  # def import
  #   return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
  #   return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

  #   CsvImportService.new.call(params[:file])

  #   redirect_to request.referer, notice: 'Import started...'
  # end

  def import
    return render json: { notice: 'No file added' }, status: :unprocessable_entity if params[:file].nil?
    return render json: { notice: 'Only CSV files allowed' }, status: :unprocessable_entity unless params[:file].content_type == 'text/csv'

    CsvImportService.new.call(params[:file])

    render json: { notice: 'Import started...' }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :name, :surname, :phone, :preferences)
    end
end
