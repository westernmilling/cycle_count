require 'rails_helper'

feature 'User creates a new user' do
  background do
    sign_in_with(user.email, user.password)
  end

  given(:user) { create(:user, :admin) }

  context 'when details are valid' do
    given(:name) { Faker::Name.name }
    given(:email) { Faker::Internet.email }
    given(:role) { :moderator }

    scenario 'they see a success message' do
      visit new_admin_user_path

      fill_in :user_name, with: name
      fill_in :user_email, with: email
      select role, from: :user_role_name
      check :user_is_active

      click_button I18n.t('admin.new.save')

      expect(page).to have_content(I18n.t('admin.create.success'))
      expect(page).to have_content(name)
      expect(page).to have_content(email)
      expect(page).to have_content(role)
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit new_admin_user_path

      click_button I18n.t('admin.new.save')

      expect(page).to have_content('error')
    end
  end

  context 'when the user does not have the admin role' do
    given(:user) { create(:user, :moderator) }

    scenario 'they see a permission error message' do
      visit new_admin_user_path

      expect(page).to have_content(I18n.t('access_denied'))
    end
  end
end
