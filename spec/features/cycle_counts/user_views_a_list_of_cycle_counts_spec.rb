require 'rails_helper'

feature 'User views a list of cycle_counts' do
  background { sign_in_with(current_user.email, current_user.password) }
  given(:current_user) { create(:user, :cycle_counter) }

  context 'when there are cycle_counts' do
    given!(:cycle_counts) { create_list(:cycle_count, 3) }

    scenario 'they see cycle_counts' do
      visit cycle_counts_path

      expect_user_row cycle_counts[0].decorate
      expect_user_row cycle_counts[1].decorate
      expect_user_row cycle_counts[2].decorate
    end
  end

  def expect_user_row(cycle_count)
    expect(page).to have_content(cycle_count.location.description)
    expect(page).to have_content(cycle_count.formatted_requested_date)
  end
end
