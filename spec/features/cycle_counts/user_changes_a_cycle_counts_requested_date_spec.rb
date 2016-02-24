require 'rails_helper'

feature 'User changes location description' do
  background { sign_in_with(user.email, user.password) }
  given(:user) { create(:user, :cycle_counter) }
  given(:cycle_count) { create(:cycle_count) }
  given(:date) { Faker::Date.forward(30) }

  scenario 'change description' do
    visit edit_cycle_count_path(cycle_count)

    fill_in :cycle_count_requested_date, with: date
    click_on I18n.t('cycle_counts.edit.save')

    expect(page).to have_content(I18n.t('cycle_counts.update.success'))
    expect(page).to have_content(date)
    expect(page).to have_content(cycle_count.created_by.email)
    expect(page).to have_content(user.email)
  end
end
