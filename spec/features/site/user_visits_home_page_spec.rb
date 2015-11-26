require 'rails_helper'

feature 'User visits home page' do
  scenario 'they see a welcome message' do
    visit root_path

    expect(page).to have_css('div h1', text: I18n.t('home.title'))
    expect(page).to have_css('div p', text: I18n.t('home.greeting'))
  end
end
