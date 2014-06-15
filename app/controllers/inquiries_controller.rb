class InquiriesController < ApplicationController

  before_action :confirm_logged_in, only: [:new, :create]

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(params[:inquiry])
    @inquiry.request = request
    if @inquiry.deliver
      flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your message!'
      redirect_to support_path
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

  def show

  end

end
