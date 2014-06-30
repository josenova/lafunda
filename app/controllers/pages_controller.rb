class PagesController < ApplicationController

  before_action :already_logged_in, only: [:confirm]
  before_action :confirm_logged_in, only: [:community]

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

  def deposit
  end

  def withdraw
  end

end
