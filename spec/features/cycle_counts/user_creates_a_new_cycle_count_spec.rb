require 'rails_helper'

feature 'User creates a new cycle_count' do
  background { sign_in_with(user.email, user.password) }
  given(:user) { create(:user, :cycle_counter) }

  context 'when details are valid' do
    given!(:locations) { create_list(:location, 2) }
    given(:requested_date) { Faker::Date.forward(30) }

    scenario 'they see a success message' do
      visit new_cycle_count_path

      select locations[0].description, from: :cycle_count_location_id
      fill_in :cycle_count_requested_date, with: requested_date

      click_button I18n.t('cycle_counts.new.save')

      expect(page).to have_content(I18n.t('cycle_counts.create.success'))
      expect(page).to have_content(locations[0].description)
      expect(page).to have_content(requested_date.strftime('%m/%d/%Y'))
      expect(page).to have_content(user.email)
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit new_cycle_count_path

      click_button I18n.t('cycle_counts.new.save')

      expect(page).to have_content('error')
    end
  end

  context 'when the user does not have the admin or cycle_counter role' do
    given(:user) { create(:user, :moderator) }

    scenario 'they see a permission error message' do
      visit new_cycle_count_path

      expect(page).to have_content(I18n.t('access_denied'))
    end
  end
end
