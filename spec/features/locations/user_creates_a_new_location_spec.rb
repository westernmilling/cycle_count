require 'rails_helper'

feature 'User creates a new location' do
  background do
    sign_in_with(user.email, user.password)
  end

  given(:user) { create(:user, :cycle_counter) }

  context 'when details are valid' do
    given(:location_number) { Faker::Number.number(6) }
    given(:area_number) { Faker::Number.number(6) }
    given(:sequence_number) { Faker::Number.number(6) }
    given(:description) { Faker::Commerce.product_name }

    scenario 'they see a success message' do
      visit new_location_path

      fill_in :location_location_number, with: location_number
      fill_in :location_area_number, with: area_number
      fill_in :location_sequence_number, with: sequence_number
      fill_in :location_description, with: description

      click_button I18n.t('locations.new.save')

      expect(page).to have_content(I18n.t('locations.create.success'))
      expect(page).to have_content(location_number)
      expect(page).to have_content(area_number)
      expect(page).to have_content(sequence_number)
      expect(page).to have_content(description)
      expect(page).to have_content(user.email)
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit new_location_path

      click_button I18n.t('locations.new.save')

      expect(page).to have_content('error')
    end
  end

  context 'when the user does not have the admin or cycle_counter role' do
    given(:user) { create(:user, :moderator) }

    scenario 'they see a permission error message' do
      visit new_location_path

      expect(page).to have_content(I18n.t('access_denied'))
    end
  end
end
