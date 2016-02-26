class PalletsController < ApplicationController
  before_action -> { authorize :pallet }
  respond_to :html

  def new
    render_new
  end

  def create
    render_new and return unless entry.valid?

    handle_service_result(
      create_pallet,
      -> { redirect_to cycle_count_path(params[:cycle_count_id]) },
      -> { render_new })
  end

  private

  def render_new
    render :new, locals: { pallet: pallet, entry: entry }
  end

  def create_pallet
    CreatePallet.call(entry_params.merge(params.slice(:cycle_count_id)))
  end

  def entry_params
    return {} if params[:entry].nil?

    params
      .require(:entry)
      .permit(:pallet_number)
  end

  def entry
    @entry ||= PalletEntry.new(entry_params)
  end

  def pallet
    @pallet ||= Pallet.new(entry_params).decorate
  end
end
