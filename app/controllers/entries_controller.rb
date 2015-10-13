class EntriesController < ApplicationController

  before_action :confirm_logged_in, only: [:create]
  before_action :confirm_inquiry_owner, only: [:create]

  def create

    @entry = @inquiry.entries.new(entry_params)
    @entry.author = @current_user.name + ' ' + @current_user.surname
    @entry.employee = true if @admin_status

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @inquiry, notice: t('flash.entry_created') }
        UserMailer.entry_mail(@inquiry_owner, @inquiry).deliver if @current_user.admin
      else
        format.html { redirect_to @inquiry, error: t('flash.entry_not_created') }
        logger.warn "Entry could not be created: #{@entry.attributes.inspect}, is valid?: #{@entry.valid?}"
      end
    end

    # Close and open tickets automatically
    if @admin_status
      @inquiry.status = false
    else
      @inquiry.status = true
    end
    @inquiry.save
  end



private

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.require(:entry).permit(:message, :inquiry_id)
  end

  def confirm_inquiry_owner
    if @admin_status
      @inquiry = Inquiry.find(params[:entry][:inquiry_id])
      @inquiry_owner = User.find(@inquiry.user_id)
    else
      @inquiry = @current_user.inquiries.find(params[:entry][:inquiry_id])
    end
  end


end
