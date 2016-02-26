class CycleCountDecorator < Draper::Decorator
  delegate_all

  def formatted_requested_date
    requested_date.strftime('%m/%d/%Y')
  end

  def formatted_created_at
    created_at.strftime('%m/%d/%Y')
  end

  def formatted_updated_at
    updated_at.strftime('%m/%d/%Y')
  end
end
