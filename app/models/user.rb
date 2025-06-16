class User < ApplicationRecord
  validates :last_name, presence: true

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super.merge('foo' => 'bar')
  end
end