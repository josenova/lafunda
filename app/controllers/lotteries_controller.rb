class LotteriesController < ApplicationController

  before_action :confirm_logged_in, only: [:index]

  def index
  end

end
