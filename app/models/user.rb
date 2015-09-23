class User < ActiveRecord::Base
  # Include default devise modules.
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.nickname = auth.extra.raw_info.nickname   # assuming the user model has a nickname
      user.email = auth.extra.raw_info.email   # assuming the user model has an email
      user.image = auth.info.image # assuming the user model has an image
    end
  end
end