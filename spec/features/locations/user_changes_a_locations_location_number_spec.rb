require 'rails_helper'

feature 'User changes location location_number' do
  background { sign_in_with(user.email, user.password) }
  given(:user) { create(:user, :cycle_counter) }
  given(:location) { create(:location) }

  scenario 'change location_number' do
    visit edit_location_path(location)

    fill_in :location_location_number, with: location.location_number
    click_on I18n.t('locations.edit.save')

    expect(page).to have_content(I18n.t('locations.update.success'))
    expect(page).to have_content(location.location_number)
    expect(page).to have_content(location.created_by.email)
    expect(page).to have_content(user.email)
  end
end
