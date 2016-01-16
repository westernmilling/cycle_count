class UserPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    update?
  end

  def new?
    create?
  end

  def index?
    role?('admin')
  end

  def show?
    update?
  end

  def update?
    role?('admin')
  end

  def destroy?
    role?('admin')
  end
end
