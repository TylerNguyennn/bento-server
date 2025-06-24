class User < ApplicationRecord
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :last_name, presence: true

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
       :jwt_authenticatable, :omniauthable, omniauth_providers: [ :google_oauth2 ],
        jwt_revocation_strategy: self

  # def has_role?(role_name)
  #   roles.where(name: role_name.to_s).exists?
  # end

  def assign_role(role_name)
    role = Role.find_by(name: role_name)
    roles << role if role && !roles.exists?(role.id)
  end
end
