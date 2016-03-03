class CreatePallet
  include Interactor
  before :check_pallet_details

  def call
    Pallet.transaction do
      context.pallet = build_pallet
      context.pallet.save!
    end
    context.message = I18n.t('pallets.create.success')
  end

  protected

  def build_pallet
    Pallet.new(pallet_params)
  end

  def pallet_params
    context.to_h.slice(:cycle_count_id, :pallet_number)
  end

  def check_pallet_details
    return if Pallet.where(cycle_count_id: context.cycle_count_id,
                           pallet_number: context.pallet_number).count == 0

    context.fail!(message: I18n.t('pallets.create.failure'))
  end
end
