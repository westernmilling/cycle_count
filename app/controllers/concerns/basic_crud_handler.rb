module BasicCRUDHandler
  extend ActiveSupport::Concern

  def create
    if resource.save
      redirect_to resource, notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render :new, locals: { resource: resource }
    end
  end

  def update
    if resource.update_attributes(resource_params)
      redirect_to resource, notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render :edit, locals: { resource: resource }
    end
  end

  def resource
    @resource ||= params[:id] ? find_resource : build_resource
  end

  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  def resource_name
    @resource_name ||= controller_name.singularize
  end

  def resource_params
    @resource_params ||= send("#{resource_name}_params")
  end

  def build_resource
    resource_class.new(resource_params)
  end

  def find_resource
    resource_class.find(params[:id])
  end
end
