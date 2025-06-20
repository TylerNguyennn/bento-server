class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true if user.has_role?(:seller)
  end

  def update?
    user&.has_role?(:seller) && record.seller_id == user.id
  end

  def edit?
    update?
  end

  def destroy?
    user&.has_role?(:seller) && record.seller_id == user.id
  end
end
