require 'rails_helper'

feature 'User deletes location', js: true do
  background { sign_in_with(user.email, user.password) }
  given(:user) { create(:user, :cycle_counter) }
  given!(:location) { create(:location) }

  context 'when the delete confirm is accepted' do
    scenario 'they see a success message' do
      visit locations_path

      expect(page).to have_content(location.location_number)
      expect(page).to have_content(location.area_number)
      expect(page).to have_content(location.sequence_number)

      accept_confirm do
        click_link('Destroy')
      end

      expect(page).to have_content(I18n.t('locations.destroy.success'))
      expect(page).not_to have_content(location.location_number)
      expect(page).not_to have_content(location.area_number)
      expect(page).not_to have_content(location.sequence_number)
    end
  end

  context 'when the delete confirm is dismissed' do
    scenario 'nothing changes' do
      visit locations_path

      expect(page).to have_content(location.location_number)
      expect(page).to have_content(location.area_number)
      expect(page).to have_content(location.sequence_number)

      dismiss_confirm do
        click_link('Destroy')
      end

      expect(page).to have_content(location.location_number)
      expect(page).to have_content(location.area_number)
      expect(page).to have_content(location.sequence_number)
    end
  end
end
