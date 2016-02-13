require 'rails_helper'

feature 'User enables an inactive user' do
  background { sign_in_with(admin_user.email, admin_user.password) }
  given(:admin_user) { create(:user, :admin) }
  given(:user) { create(:user, :moderator) }

  scenario 'enables user' do
    user.is_active = 0
    user.save!

    visit edit_admin_user_path(user)

    check :user_is_active
    click_on I18n.t('admin.users.edit.save')

    expect(page).to have_content(I18n.t('admin.users.update.success'))
    expect(page).to have_content('Active')
  end
end
