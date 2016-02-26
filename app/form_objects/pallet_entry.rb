class PalletEntry < FormEntry
  attribute :pallet_number, Integer

  validates \
    :pallet_number,
    presence: true
end
