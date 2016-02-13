require 'rails_helper'

feature 'User disables an active user' do
  background { sign_in_with(admin_user.email, admin_user.password) }
  given(:admin_user) { create(:user, :admin) }
  given(:user) { create(:user, :moderator) }

  scenario 'disables user' do
    visit edit_admin_user_path(user)

    uncheck :user_is_active
    click_on I18n.t('admin.users.edit.save')

    expect(page).to have_content(I18n.t('admin.users.update.success'))
    expect(page).to have_content('Inactive')
  end
end
