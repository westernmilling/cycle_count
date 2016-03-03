require 'rails_helper'

feature 'User views a list of pallets' do
  background { sign_in_with(current_user.email, current_user.password) }
  given(:current_user) { create(:user, :cycle_counter) }

  context 'when there are pallets' do
    given!(:cycle_count) { create(:cycle_count) }
    given!(:pallets) { create_list(:pallet, 3, cycle_count_id: cycle_count.id) }

    scenario 'they see pallets' do
      visit cycle_count_path(cycle_count)

      expect_user_row pallets[0]
      expect_user_row pallets[1]
      expect_user_row pallets[2]

      expect(page).to have_content("Pallet Count #{pallets.count}")
    end
  end

  def expect_user_row(pallet)
    expect(page).to have_content(pallet.pallet_number)
  end
end
