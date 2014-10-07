class PagesController < ApplicationController

  before_action :already_logged_in, only: [:confirm]
  before_action :confirm_logged_in, only: [:community, :cashier, :bonus_center, :bonus_center_edit]
  before_action :get_funds, only: [:cashier]
  before_action :get_player_info, only: [:cashier]
  before_action :confirm_finance, only: [:bonus_center, :bonus_center_edit]

  def faq
  end

  def privacy
  end

  def terms
  end

  def responsible
  end

  def community
  end

  def confirm
  end

  def cashier
  end

  def promotions
  end

  def bonus_center
    @users = User.all
  end

  def bonus_center_edit
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @user.update(bonus_status: params[:bonus_status], bonus_updated: Time.zone.now)
        format.html { redirect_to bonus_center_url, notice: "#{@user.username} ha sido actualizado." }
      else
        format.html { render action: 'bonus_center', error: t('flash.update_failed')}
        logger.warn "User could not be updated: #{@user.attributes.inspect}, is valid?: #{@user.valid?}"
      end
    end
  end


  private
  def confirm_finance
    redirect_to root_url unless @finance_status
  end

end
