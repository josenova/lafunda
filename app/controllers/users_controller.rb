class UsersController < ApplicationController

  before_action :confirm_logged_in, only: [:show, :edit, :update]
  before_action :already_logged_in, only: [:new]
  before_action :set_user
  before_action :get_funds, only: [:show, :edit]


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          format.html { redirect_to pending_confirmation_url, notice: 'User was successfully created.' }
          format.json { render action: 'show', status: :created, location: @user }
        else
          format.html { render action: 'new', error: 'Could not save user.' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      #if @user.update(user_params)
      if @user.update(name: params[:user][:name], surname: params[:user][:surname], identification: params[:user][:identification], birthday: params[:user][:birthday], cellphone: params[:user][:cellphone], pin: params[:user][:pin])
        format.html { redirect_to account_url, notice: 'User has been updated successfully!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = @current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :name, :surname, :identification, :birthday, :cellphone, :pin, :gender)
  end

end
