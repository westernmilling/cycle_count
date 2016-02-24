class CycleCountPolicy < ApplicationPolicy
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
    role?('admin', 'cycle_counter', 'moderator')
  end

  def show?
    index?
  end

  def update?
    role?('admin', 'cycle_counter')
  end

  def destroy?
    update?
  end
end
