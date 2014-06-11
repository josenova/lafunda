class SessionsController < ApplicationController

  before_action :already_logged_in, only: [:new]

#///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  def new
  end

  def create
    #request.remote_ip
    #@remote_ip = request.env["HTTP_X_FORWARDED_FOR"]

    user = User.ci_find('username', params[:username])
    if user && user.respond_to?('each') == false && user.authenticate(params[:password]) #should be fixed, when FIND fails it returns ALL users.
      if user.confirmed?

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
            flash.now[:error] = @response
            logger.warn @response
            render 'new'
          else
            session[:user_token] = @response[:player_login_response][:player_login_result][:token]
            sign_in(:user, user)
            redirect_to account_url
          end
        else
          flash.now[:error] = @response
          logger.warn @response
          render 'new'
        end

      else
        redirect_to pending_confirmation_url
        flash[:notice] = "Please confirm your account."
      end
    else
      flash.now[:error] = 'Invalid username/password combination'
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
      redirect_to sign_in_url
    else
      redirect_to sign_in_url
    end
  end





end
