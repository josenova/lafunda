class InquiriesController < ApplicationController

  before_action :confirm_logged_in, only: [:new, :create, :show, :center, :close]
  before_action :set_inquiries, only: [:index]
  before_action :set_inquiry, only: [:show]
  before_action :confirm_admin, only: [:center, :close]

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = @current_user.inquiries.new(inquiry_params)
    respond_to do |format|
      if @inquiry.save
        format.html { redirect_to support_url, notice: t('views.ticket_created') }
        #format.json { render action: 'show', status: :created, location: @inquiry }
      else
        format.html { render action: 'new', error: t('views.ticket_failed') }
        #format.json { render json: @inquiry.errors, status: :unprocessable_entity }
        logger.warn "Ticket could not be created: #{@inquiry.attributes.inspect}, is valid?: #{@inquiry.valid?}"
      end
    end
  end

  def index
  end

  def show
    @entry = Entry.new
  end

  def center
    @inquiries = Inquiry.all
    @users = User.all
  end

  def close
    @ticket = Inquiry.find(params[:inquiry_id])
    @ticket.status = false
    @ticket.save
    redirect_to @ticket
  end



  private
  # Use callbacks to share common setup or constraints between actions.

  def set_inquiry
    if @admin_status
      @inquiry = Inquiry.find(params[:id])
      @inquiry_user = @inquiry.user_id
      @history = User.find(@inquiry_user).inquiries
    else
      @inquiry = @current_user.inquiries.find(params[:id])
    end
  end

  def set_inquiries
    @user_inquiries = @current_user.inquiries if @current_user
  end

  def confirm_admin
    redirect_to root_url unless @admin_status
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def inquiry_params
    params.require(:inquiry).permit(:subject, :message)
  end




end
