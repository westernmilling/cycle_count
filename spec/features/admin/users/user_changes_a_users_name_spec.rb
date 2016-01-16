require 'rails_helper'

feature 'User changes a users name' do
  background { sign_in_with(current_user.email, current_user.password) }
  given(:current_user) { create(:user, :admin) }
  given(:user) { create(:user, :moderator) }
  given(:name) { Faker::Name.name }

  context 'when the user is not an admin' do
    given(:current_user) { create(:user, :moderator) }

    scenario 'they see access denied' do
      visit edit_admin_user_path(user)

      expect(page).to have_content(I18n.t('access_denied'))
    end
  end

  context 'when a new name is present' do
    scenario 'they see the user details with the new name' do
      visit edit_admin_user_path(user)

      expect(page).to have_content I18n.t('admin.edit.title')

      fill_in :user_name, with: name

      click_button I18n.t('admin.edit.save')

      expect(page).to have_content(I18n.t('admin.update.success'))
      expect(page).to have_content(name)
    end
  end

  context 'when no name is present' do
    scenario 'they see an error message' do
      visit edit_admin_user_path(user)

      expect(page).to have_content I18n.t('admin.edit.title')

      fill_in :user_name, with: nil

      click_button I18n.t('admin.edit.save')

      expect(page).to have_content('error')
    end
  end
end
