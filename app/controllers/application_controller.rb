class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  #Colchian client parameters
  $source_id = 'KINBAR'
  $source_password = 'PASSFF321'
  $application_id = 'SBBR'
  $user_id = 'INETUSR'
  $logon_source = 1
  $website_id = 1014
  $partner_id = 0
  $thrid_party_token = 0
  $currency_id = 'DOP'
  $default_language = 'es-ES'
  $allow_calls = true
  $allow_emails = true
  $id_prefix = 'LF'

  before_action :set_locale
  before_action :current_user

  extend Savon::Model
  $client = client wsdl: 'http://services.colchian.eu/BOSS_DEMO/BOSSWebServices/IncomingIntegrationService/IncomingIntegrationService.svc?wsdl', proxy: 'http://quotaguard1366:93daf37f3983@us-east-1-static.quotaguard.com:9293'



  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  def confirm_logged_in
    unless @current_user
      flash[:error] = "Please log in."
      redirect_to sign_in_url
    end
  end

  def already_logged_in
    redirect_to account_url if @current_user
  end






end
