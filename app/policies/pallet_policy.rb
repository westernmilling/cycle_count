class PalletPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    role?('admin', 'cycle_counter')
  end

  def new?
    create?
  end

  def index?
    role?('admin', 'cycle_counter', 'moderator')
  end

  def show?
    update?
  end

  def update?
    false
  end

  def destroy?
    update?
  end
end
