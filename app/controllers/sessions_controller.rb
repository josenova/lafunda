class SessionsController < ApplicationController

  before_action :already_logged_in, only: [:new, :create]

#///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  def new
  end

  def create
    user = User.ci_find('username', params[:username])
    if user && user.respond_to?('each') == false
      if user.valid_for_authentication?
        if user.authenticate(params[:password]) #should be fixed, when FIND fails it returns ALL users.
          if user.confirmed?
            remote_login(user)
          else
            redirect_to pending_confirmation_url
            flash[:notice] = t('flash.confirm_account')
          end

        else
          rebound
          if user
            user.failed_attempts += 1
            if user.failed_attempts == 5
              user.lock_access!
              user.failed_attempts == 0
            end
            user.save
          end
        end

      else
        flash.now[:error] = 'Your account is locked. Please contact support.'
        render 'new'
      end

    else
      rebound
    end
  end

  def rebound
    flash.now[:error] = t('flash.invalid_combination')
    render 'new'
  end


  def remote_login(user)
    @request = %Q(
            <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
              <soapenv:Header/>
              <soapenv:Body>
                <tem:PlayerLogin>
                  <tem:sourceId>#{$source_id}</tem:sourceId>
                  <tem:sourcePassword>#{$source_password}</tem:sourcePassword>
                  <tem:playerId>#{user.username}</tem:playerId>
                  <tem:password>#{user.password_digest}</tem:password>
                  <tem:userId>#{$user_id}</tem:userId>
                  <tem:workstationId></tem:workstationId>
                  <tem:applicationId>#{$application_id}</tem:applicationId>
                  <tem:logonSource>#{$logon_source}</tem:logonSource>
                  <tem:websiteId>#{$website_id}</tem:websiteId>
                  <tem:partnerId></tem:partnerId>
                  <tem:thridPartyToken></tem:thridPartyToken>
                </tem:PlayerLogin>
              </soapenv:Body>
            </soapenv:Envelope>
            )
    @response = $client.call(:player_login, xml: @request)

    if @response.success?
      @response = @response.to_hash
      if @response[:player_login_response][:player_login_result][:error_code] != '0'
        logger.warn @response
        flash.now[:error] = t('flash.cannot_log_in')
        render 'new'
      else
        session[:user_token] = @response[:player_login_response][:player_login_result][:token]
        sign_in(:user, user)
        redirect_to account_url
      end
    else
      logger.warn 'Response failed for login'
      logger.warn @response if @response != nil
      flash.now[:error] = t('flash.cannot_log_in')
      render 'new'
    end
  end




  def destroy
    if session[:user_token]
      @request = %Q(
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
          <soapenv:Header/>
          <soapenv:Body>
            <tem:LogoutSession>
              <tem:sourceId>#{$source_id}</tem:sourceId>
              <tem:sourcePassword>#{$source_password}</tem:sourcePassword>
              <tem:token>#{session[:user_token]}</tem:token>
              <tem:applicationId>#{$application_id}</tem:applicationId>
              <tem:websiteId>#{$website_id}</tem:websiteId>
            </tem:LogoutSession>
          </soapenv:Body>
        </soapenv:Envelope>
        )
      $client.call(:logout_session, xml: @request)
      session[:user_token] = nil
      sign_out(@current_user) if @current_user
      redirect_to root_url
    else
      redirect_to root_url
    end
  end





end
