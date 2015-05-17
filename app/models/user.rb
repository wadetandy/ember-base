class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :ensure_authentication_token

  has_many :authentications

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def add_third_party_authentication(provider, omniauth_hash)
    if self.authentications.where(provider: provider, provider_uuid: omniauth_hash.uid)
      Rails.logger.info("Provider #{provider} has already been associated for user #{self.email}")
    else
      self.authentications.create({
        provider:         provider,
        provider_uuid:    omniauth_hash.uid,
        token:            omniauth_hash.credentials.token,
        token_expires_at: omniauth_hash.credentials.expires ? omniauth_hash.credentials.expires_at  :  nil
      })
    end
  end


  class << self
    def find_or_create_by_third_party_authentication(omniauth_hash)
      provider = omniauth_hash['provider']
      auth = Authentication.where({
        provider: provider,
        provider_uuid: omniauth_hash['uid']
      }).first_or_initialize

      auth.attributes = {
        token:            omniauth_hash['credentials']['token'],
        token_expires_at: omniauth_hash['credentials']['expires'] ? Time.at(omniauth_hash['credentials']['expires_at']) : nil
      }

      unless user = auth.user
        user = User.new(self.send("#{provider}_info", omniauth_hash))
        user.password = Devise.friendly_token
        user.authentications << auth
      end

      user.save

      user
    end

    private

    def linkedin_info(omniauth_hash)
      {
        # name:     omniauth_hash['info']['name'],
        email:    omniauth_hash['info']['email'],
        # location: omniauth_hash['info']['location']['name']
      }
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
