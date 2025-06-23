class User < ApplicationRecord
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :last_name, presence: true

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
       :jwt_authenticatable, :omniauthable, omniauth_providers: [ :google_oauth2 ],
        jwt_revocation_strategy: self


  def jwt_payload
    super.merge({ roles: self.roles.pluck(:name)
  })
  end

  def has_role?(role_name)
    roles.where(name: role_name.to_s).exists?
  end

  def assign_role(role_name)
    role = Role.find_by(name: role_name)
    roles << role if role && !roles.exists?(role.id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.email = auth.info.email if user.email.blank?
      user.password ||= Devise.friendly_token[0, 20]
      user.first_name ||= auth.info.first_name || auth.info.name.split(" ").first
      user.last_name ||= auth.info.last_name || auth.info.name.split(" ").last
      user.save!
    end
  end
end
