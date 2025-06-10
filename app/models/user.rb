class User < ApplicationRecord
  validates :role, presence: true, inclusion: { in: %w(buyer seller admin) }
  validates :name, presence: true
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super.merge('foo' => 'bar')
  end
end