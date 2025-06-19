class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    false
  end

  def create?
    false
  end
end
