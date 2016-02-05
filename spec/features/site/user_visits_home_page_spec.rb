require 'rails_helper'

feature 'User visits home page' do
  context 'when they are signed in' do
    background { sign_in_with(user.email, user.password) }
    given(:user) { create(:user, :moderator) }

    scenario 'they see a welcome message' do
      visit root_path

      expect(page).to have_css('div h1', text: I18n.t('home.title'))
      expect(page).to have_css('div p', text: I18n.t('home.greeting'))
    end
  end

  context 'when they are not signed in' do
    scenario 'they see you need to sign in page' do
      visit root_path

      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
    end
  end
end
