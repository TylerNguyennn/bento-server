class UserPolicy < ApplicationPolicy
  def self.allowed_signup_roles
    %w[buyer seller]
  end
end
