require 'rails_helper'

feature 'User views a list of locations' do
  background { sign_in_with(current_user.email, current_user.password) }
  given(:current_user) { create(:user, :cycle_counter) }

  context 'when there are locations' do
    given!(:locations) { create_list(:location, 3) }

    scenario 'they see locations' do
      visit locations_path

      expect_user_row locations[0]
      expect_user_row locations[1]
      expect_user_row locations[2]
    end
  end

  def expect_user_row(location)
    [
      :location_number,
      :area_number,
      :sequence_number
    ].each do |attribute|
      expect(page).to have_content(location.send(attribute))
    end
  end
end
