class InquiriesController < ApplicationController

  before_action :confirm_logged_in, only: [:new, :create]
  before_action :set_inquiries, only: [:index]

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.user = @current_user
    respond_to do |format|
      if @inquiry.save
        format.html { redirect_to support_url, notice: 'Ticket was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inquiry }
      else
        format.html { render action: 'new', error: 'Could not create ticket.' }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  def index

  end

  def show

  end



  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inquiries
    @user_inquiries = @current_user.inquiries if @current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def inquiry_params
    params.require(:inquiry).permit(:subject, :message)
  end


end
