class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable, :rememberable, :validatable and :omniauthable, :registerable, :database_authenticatable, :recoverable
  devise  :confirmable, :trackable, :lockable

  before_create :save_in_remote

  before_validation do
    self.cellphone = cellphone.gsub(/[^0-9]/, '') if cellphone.present?
    self.identification = identification.gsub(/[^0-9]/, '') if identification.present?
    self.name = name.downcase.camelize
    self.surname = surname.downcase.camelize
    self.email = email.downcase
  end


#////////////////////////////////////////////////////////////////////////////////////////

  scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase).first }

#/////////////////////////////////////////////////////////////////////////////////////////

  attr_readonly :username, :email

  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: {minimum: 4, maximum: 14},
            format: {with: /\A[-a-z\d_]+\Z/i, message: 'debe contener solo letras, numeros y guiones.'}
  has_secure_password
  validates :password, length: { minimum: 8, maximum: 120 }, on: :create
  validates :password, length: {minimum: 8, maximum: 120}, on: :update, allow_blank: true

  validates :email, presence:   true,
            format:     { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }


  validates :name, presence: true, length: { maximum: 20 }
  validates :surname, presence: true, length: { maximum: 20 }
  validates :gender, presence: true
  validates :identification, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 11 }
  validates :birthday, presence: true
  validates :cellphone, presence: true, uniqueness: true, numericality: { only_integer: true }

  validates :pin, presence: true, length: { is: 4 }, numericality: { only_integer: true, greater_than: -1 }

  validate :at_least_18


  def at_least_18
    if self.birthday
      errors.add(:birthday, 'You must be 18 years or older.') if self.birthday > 18.years.ago.to_date
    end
  end



#////////////////////////////////////////////////////////////////////////////////////////////

  def save_in_remote
    #@client = Savon.client(wsdl: 'http://services.colchian.eu/BOSS_DEMO/BOSSWebServices/IncomingIntegrationService/IncomingIntegrationService.svc?wsdl')
    @request = %Q(
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
        <soapenv:Header/>
        <soapenv:Body>
          <tem:SignUpPlayer>
            <tem:sourceId>#{$source_id}</tem:sourceId>
            <tem:sourcePassword>#{$source_password}</tem:sourcePassword>
            <tem:webSiteId>#{$website_id}</tem:webSiteId>
            <tem:partnetId></tem:partnetId>
            <tem:playerId>#{self.username}</tem:playerId>
            <tem:firstName>#{self.name}</tem:firstName>
            <tem:lastName>#{self.surname}</tem:lastName>
            <tem:middleName></tem:middleName>
            <tem:password>#{self.password_digest}</tem:password>
            <tem:nickname>#{self.username}</tem:nickname>
            <tem:firstSecurityQuestion>0</tem:firstSecurityQuestion>
            <tem:firstSecurityAnswer></tem:firstSecurityAnswer>
            <tem:secondSecurityQuestion>0</tem:secondSecurityQuestion>
            <tem:secondSecurityAnswer></tem:secondSecurityAnswer>
            <tem:thirdSecurityQuestion>0</tem:thirdSecurityQuestion>
            <tem:thirdSecurityAnswer></tem:thirdSecurityAnswer>
            <tem:currencyId>#{$currency_id}</tem:currencyId>
            <tem:phone></tem:phone>
            <tem:workPhone></tem:workPhone>
            <tem:cellPhone>#{self.cellphone}</tem:cellPhone>
            <tem:allowCalls>#{$allow_calls}</tem:allowCalls>
            <tem:fax></tem:fax>
            <tem:email>#{self.email}</tem:email>
            <tem:secondEmail></tem:secondEmail>
            <tem:allowEmail>#{$allow_emails}</tem:allowEmail>
            <tem:address></tem:address>
            <tem:secondAddress></tem:secondAddress>
            <tem:city></tem:city>
            <tem:state></tem:state>
            <tem:country></tem:country>
            <tem:zipCode></tem:zipCode>
            <tem:referral></tem:referral>
            <tem:defaultLanguage>#{$default_language}</tem:defaultLanguage>
            <tem:externalCode></tem:externalCode>
            <tem:secondaryExternalCode></tem:secondaryExternalCode>
            <tem:signupIP></tem:signupIP>
            <tem:websiteSpecificConfigurationParameter></tem:websiteSpecificConfigurationParameter>
          </tem:SignUpPlayer>
        </soapenv:Body>
      </soapenv:Envelope>
      )
    @response = $client.call(:sign_up_player, xml: @request)

    if @response.success?
      @response = @response.to_hash
      if @response[:sign_up_player_response][:sign_up_player_result][:error_code] != '0'
        self.errors.add(:base, @response)
        return false
      else
        return true
      end
    else
      self.errors.add(:base, @response)
      return false
    end
  end
end
