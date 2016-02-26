require 'rails_helper'

feature 'User deletes cycle count', js: true do
  background { sign_in_with(user.email, user.password) }
  given(:user) { create(:user, :cycle_counter) }
  given!(:cycle_count) { create(:cycle_count).decorate }

  context 'when the delete confirm is accepted' do
    scenario 'they see a success message' do
      visit cycle_counts_path

      expect(page).to have_content(cycle_count.location.description)
      expect(page).to have_content(cycle_count.formatted_requested_date)

      accept_confirm do
        click_link('Destroy')
      end

      expect(page).to have_content(I18n.t('cycle_counts.destroy.success'))
      expect(page).not_to have_content(cycle_count.location.description)
      expect(page).not_to have_content(cycle_count.formatted_requested_date)
    end
  end

  context 'when the delete confirm is dismissed' do
    scenario 'nothing changes' do
      visit cycle_counts_path

      expect(page).to have_content(cycle_count.location.description)
      expect(page).to have_content(cycle_count.formatted_requested_date)

      dismiss_confirm do
        click_link('Destroy')
      end

      expect(page).to have_content(cycle_count.location.description)
      expect(page).to have_content(cycle_count.formatted_requested_date)
    end
  end
end
