require 'rails_helper'

feature 'User adds a note to a pallet' do
  background { sign_in_with(user.email, user.password) }
  given(:user) { create(:user, :cycle_counter) }
  given(:pallet) { create(:pallet) }

  context 'add note' do
    given(:notes) { Faker::Lorem.sentence }

    scenario 'they see a success message' do
      visit edit_cycle_count_pallet_path(pallet.cycle_count_id, pallet)

      fill_in :pallet_notes, with: notes

      click_button I18n.t('pallets.edit.save')

      expect(page).to have_content(I18n.t('pallets.update.success'))
    end
  end
end
