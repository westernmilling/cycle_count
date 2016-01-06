module InteractorHandler
  extend ActiveSupport::Concern

  def handle_service_result(result, on_success, on_failure)
    if result.success?
      flash[:notice] = result.message
      on_success.call
    else
      flash[:alert] = result.message
      on_failure.call
    end
  end
end
