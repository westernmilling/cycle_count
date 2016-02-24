require 'rails_helper'

feature 'User changes cycle count location_id' do
  background { sign_in_with(user.email, user.password) }
  given(:user) { create(:user, :cycle_counter) }
  given(:cycle_count) { create(:cycle_count) }
  given!(:locations) { create_list(:location, 2) }

  scenario 'change location_id' do
    visit edit_cycle_count_path(cycle_count)

    select locations[1].description, from: :cycle_count_location_id

    click_on I18n.t('cycle_counts.edit.save')

    expect(page).to have_content(I18n.t('cycle_counts.update.success'))
    expect(page).to have_content(locations[1].description)
    expect(page).to have_content(cycle_count.created_by.email)
    expect(page).to have_content(user.email)
  end
end
