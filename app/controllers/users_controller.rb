class UsersController < ApplicationController

  before_action :confirm_logged_in, only: [:show, :edit, :update]
  before_action :already_logged_in, only: [:new, :create]
  before_action :get_funds, only: [:show, :edit]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to pending_confirmation_url, notice: t('flash.user_created') }
        #format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new', error: t('flash.user_not_created') }
        logger.warn "User could not be created: #{@user.attributes.inspect}, is valid?: #{@user.valid?}"
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      #if @user.update(user_params)
      if @current_user.update(cellphone: params[:user][:cellphone], pin: params[:user][:pin], city: params[:user][:city])
        format.html { redirect_to account_url, notice: t('flash.update_succesful') }
        #format.json { head :no_content }
      else
        format.html { render action: 'edit', error: t('flash.update_failed') }
        logger.warn "User could not be updated: #{@current_user.attributes.inspect}, is valid?: #{@current_user.valid?}"
        #format.json { render json: @current_user.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :email_confirmation, :name, :surname, :identification, :birthday, :cellphone, :pin, :gender, :city)
  end



end
