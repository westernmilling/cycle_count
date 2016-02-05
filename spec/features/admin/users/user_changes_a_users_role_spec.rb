require 'rails_helper'

feature 'User changes a users role' do
  background { sign_in_with(current_user.email, current_user.password) }
  given(:current_user) { create(:user, :admin) }
  given(:user) { create(:user, :moderator) }
  given(:role) { 'cycle_counter' }

  context 'when the user is not an admin' do
    given(:current_user) { create(:user, :moderator) }

    scenario 'they see access denied' do
      visit edit_admin_user_path(user)

      expect(page).to have_content(I18n.t('access_denied'))
    end
  end

  context 'when a new name is present' do
    scenario 'they see the user details with the new role' do
      visit edit_admin_user_path(user)

      expect(page).to have_content I18n.t('admin.edit.title')

      select role, from: :user_role_name

      click_button I18n.t('admin.edit.save')

      expect(page).to have_content(I18n.t('admin.update.success'))
      expect(page).to have_content(role)
    end
  end
end
