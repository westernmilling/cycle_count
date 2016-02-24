class LocationsController < ApplicationController
  include BasicCRUDHandler
  before_action -> { authorize :location }
  respond_to :html

  def index
    render_index
  end

  def show
    render_show
  end

  def new
    render_new
  end

  def edit
    render_edit
  end

  def destroy
    if location.destroy
      redirect_to locations_path, notice: t('.success')
    else
      redirect_to locations_path, alert: t('.failure')
    end
  end

  private

  def render_index
    render :index, locals: { locations: locations }
  end

  def render_show
    render :show, locals: { location: location }
  end

  def render_new
    render :new, locals: { resource: location }
  end

  def render_edit
    render :edit, locals: { resource: location }
  end

  def location_params
    return {} if params[:location].nil?

    params
      .require(:location)
      .permit(:location_number, :area_number, :sequence_number, :description)
  end

  def location
    @location ||= params[:id] ? find_location : build_location
  end

  def locations
    @locations ||= Location.all.page(params[:page])
  end

  def build_location
    Location.new(location_params)
  end

  def find_location
    Location.find(params[:id])
  end
end
