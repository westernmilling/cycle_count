require 'rails_helper'

feature 'User creates a new pallet' do
  background { sign_in_with(user.email, user.password) }
  given(:user) { create(:user, :cycle_counter) }
  given(:cycle_count) { create(:cycle_count) }

  context 'when details are valid' do
    given(:pallet_number) { Faker::Number.number(6) }

    scenario 'they see a success message' do
      visit new_cycle_count_pallet_path(cycle_count)

      fill_in :entry_pallet_number, with: pallet_number

      click_button I18n.t('pallets.new.save')

      expect(page).to have_content(I18n.t('pallets.create.success'))
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit new_cycle_count_pallet_path(cycle_count)

      click_button I18n.t('pallets.new.save')

      expect(page).to have_content('error')
    end
  end

  context 'when the user does not have the admin or cycle_counter role' do
    given(:user) { create(:user, :moderator) }

    scenario 'they see a permission error message' do
      visit new_cycle_count_pallet_path(cycle_count)

      expect(page).to have_content(I18n.t('access_denied'))
    end
  end
end
