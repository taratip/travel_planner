require 'rails_helper'

feature 'user signs out', %q(
  As a signed-in user
  I want to sign out
  So that I can protect my account when I am done using the application

  Acceptance Criteria:
  * I must see option to sign out
  * When I'm signed out, I cannot view itinerary or access any application features
) do
 let!(:user) { User.create(username: "guest", email: "user@example.com", password: "password1") }

  scenario 'user successfully signs out' do
    visit new_user_session_path

    fill_in 'Login', with: 'user@example.com'
    fill_in 'Password', with: 'password1'

    click_button 'Sign in'

    click_link 'Sign out'

    expect(page).to have_content("Signed out successfully.")
    expect(page).not_to have_content("Itineraries")
  end
end
