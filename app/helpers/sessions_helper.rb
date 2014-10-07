module SessionsHelper



  private

  def current_user
    if session[:user_token]

      @request = %Q(
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
         <soapenv:Header/>
         <soapenv:Body>
            <tem:ValidateSession>
               <tem:sourceId>#{$source_id}</tem:sourceId>
               <tem:sourcePassword>#{$source_password}</tem:sourcePassword>
               <tem:token>#{session[:user_token]}</tem:token>
            </tem:ValidateSession>
         </soapenv:Body>
      </soapenv:Envelope>
      )
      @response = $client.call(:validate_session, xml: @request)

      if @response.success?
        @response = @response.to_hash
        if @response[:validate_session_response][:validate_session_result][:error_code] != '0'
          logger.warn @response
          session[:user_token] = nil
          sign_out(@current_user) if @current_user
          @current_user = nil
          flash.now[:alert] = 'Your session has expired. Please log in.'
          redirect_to sign_in_url
        else
          @current_user ||= User.ci_find('username', @response[:validate_session_response][:validate_session_result][:result])
        end
      else
        logger.warn 'No response.'
        session[:user_token] = nil
        sign_out(@current_user) if @current_user
        @current_user = nil
        flash.now[:error] = 'Cannot sign in. Please try again later.'
        redirect_to sign_in_url
      end
    end
  end


  def admin_status
    @admin_status = true if @current_user && @current_user.admin
  end

  def finance_status
    @finance_status = true if @current_user && @current_user.username == 'josenova'
  end

  def current_url
    @current_url = request.original_url
  end

  def get_funds
    if @current_user

      @request = %Q(
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
         <soapenv:Header/>
         <soapenv:Body>
            <tem:GetFunds>
               <tem:sourceId>#{$source_id}</tem:sourceId>
               <tem:sourcePassword>#{$source_password}</tem:sourcePassword>
               <tem:playerId>#{@current_user.username}</tem:playerId>
            </tem:GetFunds>
         </soapenv:Body>
      </soapenv:Envelope>
      )
      @response = $client.call(:get_funds, xml: @request)

      if @response.success?
        @response = @response.to_hash
        if @response[:get_funds_response][:get_funds_result][:error_code] != '0'
          logger.warn @response
        else
          @current_user_funds ||= sprintf( "%0.02f", @response[:get_funds_response][:get_funds_result][:result])
        end
      else
        logger.warn @response if @response
      end
    end
  end


  def get_player_info
    if @current_user
      @current_user_bonus_funds = sprintf( "%0.02f",0)
=begin
      @bonus_client = Savon.client(wsdl: 'http://wagering.lafunda.com.do/BOSSWebServices/SportsBettingService/SportsBettingService.asmx?wsdl')

      @request = %Q(
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:spor="SportsBettingService">
        <soapenv:Header/>
        <soapenv:Body>
          <spor:GetPlayerInfo>
          <spor:sourceID>#{$source_id}</spor:sourceID>
          <spor:passwordID>#{$source_password}</spor:passwordID>
          <spor:token>#{session[:user_token]}</spor:token>
          <spor:withCurrencyOfPlayer>false</spor:withCurrencyOfPlayer>
        </spor:GetPlayerInfo>
      </soapenv:Body>
      </soapenv:Envelope>
      )
      @response = @bonus_client.call(:get_player_info, xml: @request)

      if @response.success?
        @response = @response.to_hash
        if @response[:get_player_info_response][:get_player_info_result][:error_code] != '0'
          logger.warn @response
        else
          @current_user_bonus_funds ||= sprintf( "%0.02f", @response[:get_player_info_response][:get_player_info_result][:player_info][:current_free_play_balance])
          logger.warn @response
        end
      else
        logger.warn @response if @response
      end
=end
    end
  end






end

