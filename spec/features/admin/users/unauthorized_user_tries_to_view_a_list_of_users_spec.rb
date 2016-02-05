require 'rails_helper'

feature 'Unauthorized user tries to view a list of users' do
  context 'when the user is a moderator' do
    background { sign_in_with(current_user.email, current_user.password) }
    given(:current_user) { create(:user, :moderator) }

    scenario 'they see an access denied message' do
      visit edit_admin_user_path(current_user)

      expect(page).to have_content('Access Denied')
    end
  end

  context 'when the user is a cycle_counter' do
    background { sign_in_with(current_user.email, current_user.password) }
    given(:current_user) { create(:user, :cycle_counter) }
    scenario 'they see an access denied message' do
      visit edit_admin_user_path(current_user)

      expect(page).to have_content('Access Denied')
    end
  end
end
