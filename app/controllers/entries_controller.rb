class EntriesController < ApplicationController

  before_action :confirm_inquiry_owner, only: [:create]

  def create

    @entry = @inquiry.entries.new(entry_params)
    @entry.author = @current_user.name + ' ' + @current_user.surname

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @inquiry, notice: t('flash.entry_created') }
        #format.json { render action: 'show', status: :created, location: @inquiry }
      else
        format.html { redirect_to @inquiry, error: t('flash.entry_not_created') }
        #format.json { render json: @inquiry.errors, status: :unprocessable_entity }
        logger.warn "Entry could not be created: #{@entry.attributes.inspect}, is valid?: #{@entry.valid?}"
      end
    end
  end



private

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.require(:entry).permit(:message, :inquiry_id)
  end

  def confirm_inquiry_owner
    @inquiry = @current_user.inquiries.find(params[:entry][:inquiry_id])
  end


end
