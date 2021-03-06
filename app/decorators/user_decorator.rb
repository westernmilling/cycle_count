class UserDecorator < Draper::Decorator
  delegate_all

  def active_label
    is_active == 1 ? 'Active' : 'Inactive'
  end

  def formatted_created_at
    created_at.strftime('%m/%d/%Y')
  end

  def formatted_updated_at
    updated_at.strftime('%m/%d/%Y')
  end
end
