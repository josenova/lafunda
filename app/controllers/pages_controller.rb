class PagesController < ApplicationController

  before_action :already_logged_in, only: [:confirm]
  before_action :confirm_logged_in, only: [:community, :cashier]
  before_action :get_funds, only: [:cashier]

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

end
