class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable, :rememberable, :validatable and :omniauthable, :registerable, :database_authenticatable, :recoverable, :async
  devise :confirmable, :trackable, :lockable

  has_many :inquiries, dependent: :destroy

  before_create :create_in_remote

  before_validation do
    self.cellphone = cellphone.strip.gsub(/[^0-9]/, '') if cellphone.present?
    self.name = name.strip.downcase.split.map(&:capitalize).join(" ") if name.present?
    self.surname = surname.strip.downcase.split.map(&:capitalize).join(" ") if surname.present?
    self.email = email.strip.downcase if email.present?
    self.city = city.strip.downcase.camelize if city.present?
    self.identification = identification.strip.gsub(/[^0-9]/, '') if identification.present?
  end

#////////////////////////////////////////////////////////////////////////////////////////

  scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase).first }

#/////////////////////////////////////////////////////////////////////////////////////////

  validates_confirmation_of :email

  attr_readonly :username, :email

  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 5, maximum: 14 },
            format: { with: /\A[-a-z\d_]+\Z/i }

  has_secure_password
  validates :password, presence: true, length: { minimum: 8, maximum: 120 },
            format: { with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z\d@$#%_-]+\z/ }, on: :create
  validates :password, length: { minimum: 8, maximum: 120 },
            format: { with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z\d@$#%_-]+\z/ }, on: :update, allow_blank: true

  validates :email, presence: true, length: { maximum: 50 },
            format:     { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }

  validates :name, presence: true, length: { minimum: 2, maximum: 35 }, format: { with: /\A([a-z]+\s)*[a-z]+\Z/i }
  validates :surname, presence: true, length: { minimum: 2, maximum: 35 }, format: { with: /\A([a-z]+\s)*[a-z]+\Z/i }
  validates :identification, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 11 }

  validates :birthday, presence: true

  validates :cellphone, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { minimum: 10, maximum: 11}

  validates :country, presence: true
  validates :state, presence: true, length: { maximum: 40}
  validates :city, presence: true, length: { maximum: 40}
  validates :address, presence: true, length: { maximum: 120}

  validates :pin, presence: true, length: { is: 4 }, numericality: { only_integer: true, greater_than: -1 }

  validates :terms_of_service, acceptance: true, :allow_nil => false, :on => :create

  validate :at_least_18

  def at_least_18
    if self.birthday
      errors.add(:birthday, I18n.t('activerecord.errors.models.user.attributes.birthday.must_be_over')) if self.birthday > 18.years.ago.to_date
    end
  end


#////////////////////////////////////////////////////////////////////////////////////////////

  def create_in_remote
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
            <tem:firstSecurityQuestion>1</tem:firstSecurityQuestion>
            <tem:firstSecurityAnswer>#{self.pin}</tem:firstSecurityAnswer>
            <tem:secondSecurityQuestion>2</tem:secondSecurityQuestion>
            <tem:secondSecurityAnswer>#{self.identification}</tem:secondSecurityAnswer>
            <tem:thirdSecurityQuestion>3</tem:thirdSecurityQuestion>
            <tem:thirdSecurityAnswer>#{self.birthday}</tem:thirdSecurityAnswer>
            <tem:currencyId>#{$currency_id}</tem:currencyId>
            <tem:phone>#{self.cellphone}</tem:phone>
            <tem:workPhone></tem:workPhone>
            <tem:cellPhone>#{self.cellphone}</tem:cellPhone>
            <tem:allowCalls>#{$allow_calls}</tem:allowCalls>
            <tem:fax></tem:fax>
            <tem:email>#{self.email}</tem:email>
            <tem:secondEmail></tem:secondEmail>
            <tem:allowEmail>#{$allow_emails}</tem:allowEmail>
            <tem:address>#{self.address}</tem:address>
            <tem:secondAddress></tem:secondAddress>
            <tem:city>#{self.city}</tem:city>
            <tem:state>#{self.state}</tem:state>
            <tem:country>#{self.country}</tem:country>
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
        logger.warn "User could not be created in remote: response: #{@response}"
        return false
      else
        return true
      end
    else
      logger.warn "Call failed for user create at remote: Response was unsuccessful."
    end
  end
end
