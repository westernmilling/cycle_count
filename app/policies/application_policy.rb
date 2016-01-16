class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  # Scope
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  protected

  def admin?
    user.role_name == 'admin'
  end

  def moderator?
    user.role_name == 'moderator'
  end

  def cycle_counter?
    user.role_name == 'cycle_counter'
  end

  def role?(*roles)
    return false if user.nil?
    user.role_name.in?(roles.to_a)
  end
end
