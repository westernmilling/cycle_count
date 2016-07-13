class PalletsController < ApplicationController
  include BasicCRUDHandler

  before_action -> { authorize :pallet }
  respond_to :html

  def create
    render_new and return unless entry.valid?

    handle_service_result(
      create_pallet,
      -> { redirect_to cycle_count_path(params[:cycle_count_id]) },
      -> { render_new }
    )
  end

  def update
    if resource.update_attributes(resource_params)
      redirect_to cycle_count_path(resource.cycle_count_id),
                  notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render_edit
    end
  end

  protected

  def render_new
    render :new, locals: { entry: entry }
  end

  def create_pallet
    CreatePallet.call(entry_params.merge(params.slice(:cycle_count_id)))
  end

  def pallet_params
    return {} if params[:pallet].nil?

    params
      .require(:pallet)
      .permit(:pallet_number,
              :notes)
  end

  def entry
    @entry ||= PalletEntry.new(entry_params)
  end

  def entry_params
    return {} if params[:entry].nil?

    params
      .require(:entry)
      .permit(:pallet_number)
  end
end
