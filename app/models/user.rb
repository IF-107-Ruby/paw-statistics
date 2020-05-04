class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  devise :database_authenticatable, :recoverable,
         :rememberable, :validatable, :omniauthable

  validates :first_name, :email, presence: true
  validates :first_name, :last_name, length: { in: 3..50 }
  validates :email, format: { with: VALID_EMAIL_REGEX }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create(
      first_name: auth.info.name,
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20]
    )
  end
end
